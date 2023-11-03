// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RentalContract {
    address public landlord;
    address public tenant;
    uint256 public rentAmount;

    //date
    uint256 public leaseStartDate;
    uint256 public leaseEndDate;


    bool public leaseActive;

    
    string public landlordComplaint;
    string public tenantComplaint;

    constructor(
        address _tenant,
        uint256 _rentAmount,
        uint256 _leaseDays,
        uint256 _startDate
    ) {
        tenant = _tenant;
        rentAmount = _rentAmount;
        leaseStartDate = _startDate;
        leaseEndDate = _startDate + (_leaseDays * 1 days);
        leaseActive = true;
        landlord = msg.sender;
    }

    modifier onlyTenant() {
        require(msg.sender == tenant, "Only the tenant can perform this operation.");
        _;
    }

    function payRent() public payable onlyTenant {
        require(leaseActive, "Lease contract has ended.");
        require(msg.value == rentAmount, "Incorrect or insufficient rent amount.");
    }

    function endLease() public onlyTenant {
        leaseActive = false;
    }

    function lodgeLandlordComplaint(string memory _complaint) public {
        require(msg.sender == landlord, "Only the landlord can make a complaint.");
        landlordComplaint = _complaint;
    }

    function lodgeTenantComplaint(string memory _complaint) public {
        require(msg.sender == tenant, "Only the tenant can make a complaint.");
        tenantComplaint = _complaint;
    }

    function leaseStatus() public view returns (bool) {
        if (block.timestamp < leaseEndDate) {
            return leaseActive;
        }
        return false;
    }
}