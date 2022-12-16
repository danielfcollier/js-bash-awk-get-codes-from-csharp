const srvCodes = require(`../../../${process.argv[2]}`);
const srvMessages = require(`../../../${process.argv[3]}`);

const DEBUG_MODE = false;

const codes = {};
const missingList = [];

Object.keys(srvCodes).forEach(code => {
  const srvCode = srvCodes[code].code;
  codes[code] = {
      code: srvCode,
      message: srvMessages[srvCode]
    };

  if (!srvMessages[srvCode]) {
    missingList.push({code, srvCode})
  }
});

if (DEBUG_MODE) {
  console.log(JSON.stringify(missingList, null, 4));
} else {
  console.log(JSON.stringify(codes, null, 4));
}
