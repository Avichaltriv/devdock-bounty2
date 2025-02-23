import { ethers } from "hardhat";

async function main() {
  // Deploy first NFT contract
  const BaseNFT = await ethers.getContractFactory("BaseNFT");
  const nft1 = await BaseNFT.deploy("ZombieNFT", "ZNFT", 1000);
  await nft1.waitForDeployment();
  console.log(`ZombieNFT deployed to ${await nft1.getAddress()}`);

  // Deploy second NFT contract
  const nft2 = await BaseNFT.deploy("VampireNFT", "VNFT", 1000);
  await nft2.waitForDeployment();
  console.log(`VampireNFT deployed to ${await nft2.getAddress()}`);

  // Deploy Mutant NFT contract
  const MutantNFT = await ethers.getContractFactory("MutantNFT");
  const mutantNFT = await MutantNFT.deploy(
    await nft1.getAddress(),
    await nft2.getAddress()
  );
  await mutantNFT.waitForDeployment();
  console.log(`MutantNFT deployed to ${await mutantNFT.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});