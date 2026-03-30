<?php
// start the output buffer in case environment used has it off by default
// in this case it doesn't, however good for scalability
ob_start();

// a function to handle php errors
// it is loaded automatically whenever requiring this file to access environment variables,
// which is the only time necessary to use php
// it also handles exceptions
function globalErrorHandler($error_number_or_exception, $error_string=null, $error_file=null, $error_line=null) {
    // clear the output buffer if it is not empty
    if (ob_get_length() > 0) { ob_clean(); }

    $errorIsException = ($error_number_or_exception instanceof Throwable);

    // non-sensitive error details
    $err = [
        "status" => "error",
        "message" => "Private error occurred"
    ];

    if (!$errorIsException) {
        $err["number"] = $error_number_or_exception; 
    } else {
        $error_string = $error_number_or_exception->getMessage(); 
        $error_file = $error_number_or_exception->getFile(); 
        $error_line = $error_number_or_exception->getLine(); 
    }

    $debug_mode_active = $_ENV["DEBUG_MODE"] ?? "false";

    // include sensitive details if debug mode active
    if ($debug_mode_active == "true") {
        $err["debug"] = [
            "error" => $error_string,
            "file" => basename($error_file),
            "line_number" => $error_line
        ];
    }

    // output error
    header("Content-type: application/json");
    echo json_encode($err);
    die(); // prevent script that called this function from continuing
}

set_error_handler("globalErrorHandler"); // set this error handler to run on every php error
set_exception_handler("globalErrorHandler"); // also for exceptions too!

// a function to populate superglobals from the environment file
// uses the industry standard .env formatting
// custom function avoids use of a library
function fetch_env() {
    $env_file_path = __DIR__ . "/.env";
    $env_file = fopen($env_file_path, "r");

    // check if file exists
    if (!file_exists($env_file_path)) {
        trigger_error("env file not found", E_USER_ERROR);
    }

    // continue until end of file
    while (!feof($env_file)) {
        $line = fgets($env_file);
        $trimmed_line = trim($line); // get rid of newline
        // check line isn't a comment OR empty
        if (str_starts_with($trimmed_line, "#") || $trimmed_line === "") {
            continue;
        }

        // add to system environment
        putenv($trimmed_line);

        // add to superglobals
        $linearray = explode("=", $trimmed_line, 2);
        $_ENV[$linearray[0]] = $linearray[1];
    }
    fclose($env_file);
}

fetch_env();

?>
