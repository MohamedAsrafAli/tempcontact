import 'package:untitleda/db_helper/respository.dart';
import 'package:untitleda/model/User.dart';

class UserService
{
  late Repository _repository;

  UserService()
  {
    _repository=Repository();
  }
  SaveUser(User user)async
  {
    return await _repository.insertData('users', user.userMap());
  }
  //read all user
readAllUsers() async
{
  return await _repository.readData('users');
}
//edit user
  UpdateUser(User user) async{

    return await _repository.updateData('users', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteUser('users',userId);

  }

}