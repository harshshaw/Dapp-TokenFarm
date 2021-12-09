// const TokenFarm = artifacts.require('TokenFarm')

// module.exports = async function(callback) {
//   let tokenFarm = await TokenFarm.deployed()
//   await tokenFarm.issueTokens()
//   // Code goes here...
//   console.log("Tokens issued!")
//   callback()
// }

const TokenFarm = artifacts.require('TokenFarm')

module.exports = async function (callback) {
  let tokenFarm = await TokenFarm.deployed()
  await tokenFarm.issueTokens()
  //Codes goes here..
  console.log("Tokens issued!")
  callback()

}