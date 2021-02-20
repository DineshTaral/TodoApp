

final BASE_URL="https://tiny-list.herokuapp.com/";
final userId=147;
String CREATE_TASK="${BASE_URL}api/v1/users/$userId/tasks";
String GET_TASK_LIST="${BASE_URL}api/v1/users/$userId/tasks";
String UPDATE_TASK="${BASE_URL}api/v1/users/$userId/tasks/";
String DELETE_TASK="${BASE_URL}api/v1/users/$userId/tasks/";
String COMPLETE_TASK="${BASE_URL}api/v1/users/$userId/tasks/";
String UNCOMPLETE_TASK="${BASE_URL}api/v1/users/$userId/tasks/";