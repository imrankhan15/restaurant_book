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
    public function createCustomer($restaurant_name, $number_of_customers,  $mobile, $date_time)
    {
        if (!$this->isUserExist($restaurant_name, $mobile, $date_time)) {
            
            $stmt = $this->conn->prepare("INSERT INTO Customer (restaurant_name, number_of_customers, mobile, date_time) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("ssss", $restaurant_name, $number_of_customers, $mobile, $date_time);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        } else {
            return USER_ALREADY_EXIST;
        }
    }


    private function isUserExist($restaurant_name, $mobile, $date_time)
    {
        $stmt = $this->conn->prepare("SELECT id FROM Customer WHERE restaurant_name = ? AND mobile = ? AND date_time = ?");
        $stmt->bind_param("sss",  $restaurant_name, $mobile, $date_time);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (!verifyRequiredParams(array( 'restaurant_name', 'number_of_customers', 'mobile', 'date_time'))) {
        //getting values
        $restaurant_name = $_POST['restaurant_name'];
        $number_of_customers = $_POST['number_of_customers'];
        $mobile = $_POST['mobile'];
        $date_time = $_POST['date_time'];
       
        
       
        //creating db operation object
        $db = new DbOperation();

        //adding user to database
        $result = $db->createCustomer($restaurant_name, $number_of_customers ,$mobile, $date_time);

        //making the response accordingly
        if ($result == USER_CREATED) {
            $response['error'] = false;
            $response['message'] = 'Booked successfully';
        } elseif ($result == USER_ALREADY_EXIST) {
            $response['error'] = true;
            $response['message'] = 'Booking already exist';
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
