<?php




$response = array();
define('DB_USERNAME', 'buetcse110');
define('DB_PASSWORD', 'ReVolut1on!');
define('DB_HOST', 'localhost');
define('DB_NAME', 'bookers');

define('USER_CREATED', 0);
define('USER_ALREADY_EXIST', 1);
define('USER_NOT_CREATED', 2);

class DbConnect
{
    private $conn;

    function __construct()
    {
    }

    /**
     * Establishing database connection
     * @return database connection handler
     */
    function connect()
    {
        

        // Connecting to mysql database
        $this->conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

        // Check for database connection error
        if (mysqli_connect_errno()) {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }

        // returing connection resource
        return $this->conn;
    }
}

class DbOperation
{
    private $conn;

    //Constructor
    function __construct()
    {
        
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

    //Function to create a new user
    public function createOwner($username, $password, $restaurant_name, $mobile, $maximum_customer_number)
    {
        if (!$this->isUserExist($username, $restaurant_name)) {
            $password = md5($password);
            $stmt = $this->conn->prepare("INSERT INTO Owner (username, password, restaurant_name, mobile, maximum_customer_number) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssss", $username, $password, $restaurant_name, $mobile, $maximum_customer_number);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        } else {
            return USER_ALREADY_EXIST;
        }
    }


    private function isUserExist($username, $restaurant_name)
    {
        $stmt = $this->conn->prepare("SELECT id FROM Owner WHERE username = ? AND restaurant_name = ?");
        $stmt->bind_param("ss", $username, $restaurant_name);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (!verifyRequiredParams(array('username', 'password', 'restaurant_name', 'mobile', 'maximum_customer_number'))) {
        //getting values
        $username = $_POST['username'];
        $password = $_POST['password'];
        $restaurant_name = $_POST['restaurant_name'];
        $mobile = $_POST['mobile'];
        $maximum_customer_number = $_POST['maximum_customer_number'];
        
       
        //creating db operation object
        $db = new DbOperation();

        //adding user to database
        $result = $db->createOwner($username, $password, $restaurant_name, $mobile, $maximum_customer_number);

        //making the response accordingly
        if ($result == USER_CREATED) {
            $response['error'] = false;
            $response['message'] = 'User created successfully';
        } elseif ($result == USER_ALREADY_EXIST) {
            $response['error'] = true;
            $response['message'] = 'User already exist';
        } elseif ($result == USER_NOT_CREATED) {
            $response['error'] = true;
            $response['message'] = 'Some error occurred';
        }
    } else {
        $response['error'] = true;
        $response['message'] = 'Required parameters are missing';
    }
} else {
    $response['error'] = true;
    $response['message'] = 'Invalid request';
}

//function to validate the required parameter in request
function verifyRequiredParams($required_fields)
{

    //Getting the request parameters
    $request_params = $_REQUEST;

    //Looping through all the parameters
    foreach ($required_fields as $field) {
        //if any requred parameter is missing
        if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {

            //returning true;
            return true;
        }
    }
    return false;
}

echo json_encode($response);
