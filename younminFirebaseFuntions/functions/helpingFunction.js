/* eslint-disable comma-dangle */

// eslint-disable-next-line require-jsdoc
exports.getDaysInMonth = (month) => {
  // instantiate a date object
  const dt = new Date();

  // dt.getMonth() will return a month between 0 - 11
  // we add one to get to the last day of the month
  // so that when getDate() is called it will return the last day of the month
  const monthNow = dt.getMonth() + 1;
  const year = dt.getFullYear();

  // this line does the magic (in collab with the lines above)
  const daysInMonth = new Date(year, month || monthNow, 0).getDate();
  return daysInMonth;
};

// eslint-disable-next-line require-jsdoc
exports.getMonthlyProgress = (todos, daysInMonth) => {
  // eslint-disable-next-line
  let monthlyProgress = 0;

  const monthlyPercentageEquation = 100 / daysInMonth;

  todos.docs.forEach((doc) => {
    monthlyProgress +=
      (doc.data()["dailyProgress"] * monthlyPercentageEquation) / 100;
  });
  return monthlyProgress;
};

const countOccurrences = (arr) =>
  arr.reduce((prev, curr) => ((prev[curr] = ++prev[curr] || 1), prev), {});

exports.mostFelt = (feelingsList) => {
  if (feelingsList.length === 0) return 1;
  const repeatNumber = countOccurrences(feelingsList);
  return parseInt(
    Object.keys(repeatNumber).reduce((a, b) =>
      repeatNumber[a] > repeatNumber[b] ? a : b
    )
  );
};

exports.getYearlyProgress = (years) => {
  const yearlyPercentageEquation = 100 / 12;

  let yearlyProgress = 0;

  years.docs.forEach((doc) => {
    yearlyProgress +=
      (doc.data()["monthlyProgress"] * yearlyPercentageEquation) / 100;
  });
  return yearlyProgress;
};
