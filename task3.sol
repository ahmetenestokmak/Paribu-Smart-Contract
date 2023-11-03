// tüm adminleri listeleme
struct Account {
  address adminAddress;
}
Account[] public admins;
function getAllAdmins() public view returns (Account[] memory) {
  return admins;
}
