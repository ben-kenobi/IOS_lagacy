1> 内购程序的APP ID需要单独指定，因为在开发时，需要独立测试，通过苹果的网站进行交互
2> 在iTunes Connect中添加可以销售的商品
3> 中间有一个审批的过程，之后就可以在应用程序中添加
4> 注册Sandbox（使用测试服务器的）用户，同样具备苹果ID的能力
	苹果官方有限定，不能用测试账号在苹果真正市场消费，一旦有消费行为，就会被禁用
5> 在应用程序信息中，填写测试账号和密码，方便审核人员测试！

开发前的注意事项：

1> 要开发内购，必须用真机
2> 真机一定不能越狱
3> BundlID 和服务器上的 App ID要一致，靠AppID来识别具体的消费

对于非消耗品，需要增加一个恢复购买的功能，提示：会一次性恢复所有的购买的非消耗品！

CollectionView





