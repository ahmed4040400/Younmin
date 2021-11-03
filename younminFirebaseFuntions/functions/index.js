/* eslint-disable comma-dangle */
/* eslint-disable object-curly-spacing */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const help = require("./helpingFunction");

admin.initializeApp({ storageBucket: "younmin-b1508.appspot.com" });

const db = admin.firestore();

exports.onUserDelete = functions.auth.user().onDelete(async (user) => {
  const snapshot = await db
    .collection("users")
    .where("uid", "==", user.uid)
    .get();
  if (snapshot.empty) {
    console.log("No matching documents.");
    return;
  }
  snapshot.forEach(async (doc) => {
    await doc.ref.delete();
  });
  const bucket = admin.storage().bucket();

  await bucket.deleteFiles(user.uid.toString() + "/");
  console.log("user: " + user.uid.toString() + "deleted with all belongs");
});

exports.newYearAdded = functions.firestore
  .document("/users/{userId}/yearlyTodo/{yearlyTodoId}/year/{yearId}")
  .onCreate((snapshot, context) => {
    return snapshot.ref.update({ yearlyProgress: 0 });
  });

exports.newMonthAdded = functions.firestore
  .document(
    "/users/{userId}/yearlyTodo/{yearlyTodoId}/year/{yearId}/month/{monthId}"
  )
  .onCreate((snapshot, context) => {
    return snapshot.ref.update({ monthlyProgress: 0 });
  });

exports.newDayAdded = functions.firestore
  .document(
    // eslint-disable-next-line max-len
    "/users/{userId}/yearlyTodo/{yearlyTodoId}/year/{yearId}/month/{monthId}/days/{dayId}"
  )
  .onCreate((snapshot, context) => {
    return snapshot.ref.update({ dailyProgress: 0 });
  });

exports.progressSetter = functions.firestore
  .document(
    // eslint-disable-next-line max-len
    "/users/{userId}/yearlyTodo/{yearlyTodoId}/year/{yearId}/month/{monthId}/days/{dayId}/dailyTodo/{dailyTodoId}"
  )
  .onUpdate(async (change, context) => {
    const dailyTodo = await admin
      .firestore()
      .collection("users")
      .doc(context.params.userId)
      .collection("yearlyTodo")
      .doc(context.params.yearlyTodoId)
      .collection("year")
      .doc(context.params.yearId)
      .collection("month")
      .doc(context.params.monthId)
      .collection("days")
      .doc(context.params.dayId)
      .collection("dailyTodo")
      .get();

    const checkedDailyTodo = dailyTodo.docs.filter(
      (doc) => doc.data()["isChecked"]
    );

    const daysCollectionRef = dailyTodo.docs[0].ref.parent.parent.parent;

    const dailyProgress =
      (checkedDailyTodo.length * 100) / dailyTodo.docs.length;
    await daysCollectionRef.doc(context.params.dayId).set({
      dailyProgress: dailyProgress,
    });
    const todos = await daysCollectionRef.get();

    const monthlyProgress = help.getMonthlyProgress(
      todos,
      help.getDaysInMonth(parseInt(context.params.monthId))
    );

    await daysCollectionRef.parent.set({ monthlyProgress: monthlyProgress });

    const yearsCollectionRef = daysCollectionRef.parent.parent;
    const years = await yearsCollectionRef.get();

    const yearlyProgress = help.getYearlyProgress(years);

    return yearsCollectionRef.parent.parent
      .doc(context.params.yearId)
      .set({ yearlyProgress: yearlyProgress });

    // eslint-disable-next-line max-len
    // ====================================================================================
  });

exports.historyMaker = functions.pubsub
  .schedule("1 * * * *")
  .onRun(async (context) => {
    const usersCollection = await admin.firestore().collection("users").get();

    return usersCollection.docs.forEach(async (userDoc) => {
      const yearlyTodos = await userDoc.ref.collection("yearlyTodo").get();
      yearlyTodos.docs.forEach(async (yearlyTodoDoc) => {
        const daysRef = userDoc.ref
          .collection("yearlyTodo")
          .doc(yearlyTodoDoc.id.toString())
          .collection("year")
          .doc(new Date().getFullYear().toString())
          .collection("month")
          .doc((new Date().getMonth() + 1).toString())
          .collection("days");
        const daysDocs = await daysRef.get();

        let lastDay = 0;
        daysDocs.docs.forEach((doc) => {
          if (
            parseInt(doc.id) > lastDay &&
            parseInt(doc.id) <= new Date().getDate()
          ) {
            lastDay = parseInt(doc.id);
          }
        });

        if (lastDay < new Date().getDate()) {
          const lastDayDoc = await daysRef.doc(lastDay.toString()).get();

          const lastDayTodoData = await daysRef
            .doc(lastDay.toString())
            .collection("dailyTodo")
            .get();

          const lastDayFeelingsList = [];

          const lastDayChecklistData = await daysRef
            .doc(lastDay.toString())
            .collection("checkList")
            .get();

          lastDayTodoData.docs.forEach(async (doc) => {
            lastDayFeelingsList.push(doc.data().feeling);
            await daysRef
              .doc(new Date().getDate().toString())
              .collection("dailyTodo")
              .add({
                date: new Date(),
                feeling: doc.data().feeling,
                isChecked: false,
                todo: doc.data().todo,
              });
          });

          lastDayChecklistData.docs.forEach(async (doc) => {
            await daysRef
              .doc(new Date().getDate().toString())
              .collection("checkList")
              .add({
                date: new Date(),
                isChecked: false,
                check: doc.data().check,
              });
          });

          daysRef.parent.parent.parent.parent.parent.parent
            .doc(yearlyTodoDoc.id)
            .collection("history")
            .add({
              mostlyFelt: help.mostFelt(lastDayFeelingsList),
              dailyProgress: lastDayDoc.data().dailyProgress,
              date: lastDayTodoData.docs[0].data().date,
            });

          await daysRef
            .doc(new Date().getDate().toString())
            .set({ dailyProgress: 0 });
        }

        console.log("history made");
      });
    });
  });
