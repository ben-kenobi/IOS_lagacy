<?php 

class itcastUsers {
    // 用户登录
    function userLogin() {
    	if (isset($_GET['username']) && isset($_GET['password'])) {
    		// 获取GET请求参数
			$accessType = '[GET]';
			$userName = $_GET['username'];
			$userPassword = $_GET['password'];
		} else if (isset($_POST['username']) && isset($_POST['password'])) {
			// 获取POST请求参数
			$accessType = '[POST]';
			$userName = $_POST['username'];
			$userPassword = $_POST['password'];
        } else if (isset($_COOKIE['userName']) && isset($_COOKIE['userPassword'])){
            
            $userName = $_COOKIE['userName'];
            $userPassword = $_COOKIE['userPassword'];
            
        }else {
			echo('非法请求。');
			return false;
		}
        
        if ($userName == 'zhangsan' && $userPassword == 'zhang') {
            
            // 设置 cookie
            setcookie('userName', $userName, time()+(86400 *30), "/");
            setcookie('userPassword', $userPassword, time()+(86400 *30),"/");
            
            // 将查询结果绑定到数据字典
            $result = array(
                            'userId' => 1,
                            'userName' => 'zhangsan'
                            );
            // 将数据字典使用JSON编码
            echo json_encode($result);
        } else {
            $result = array(
                            'code' => 0,
                            'errormassage' => '账号密码不正确'
                            );

            echo json_encode($result);
        }
        
		return true;
    }
}

header('Content-Type:application/json;charset=utf-8');
$itcast = new itcastUsers;
$itcast->userLogin();
?>
