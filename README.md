# News
![image](https://github.com/liulishuo/News/blob/master/Demo.gif)

已完成：
==============
- **登录页**:
- **新闻列表**:未找到内容字段，所以没有显示缩略内容。
- **新闻详情**:
- **新闻评论列表**:
- **动弹列表**:
- **新闻列表**:
- **个人信息页**:

未完成：
==============
- **动弹详情**:
- **头像上传**:接口未调通，报500的错误。

要点：
==============
- **网络**:封装了YTKNetwork
- **缓存**:由于项目比较简单，没有实现统一的缓存层。图片缓存用SDWebImage，网络请求的缓存用YTKNetwork（如新闻详情，缓存时间100s）。
- **分页**:上拉加载、下拉刷新用MJRefresh
- **登录页**:登录认证界面弹出时机为任意界面触发-1005错误后，弹出模态视图。
- **UI界面**:storyboard
- **信息提示**:有弹窗和HUD两种形式

注意：
==============
### 如需配置认证参数 请在AppDelegate.m如下方法内修改
```objc
- (void)configureClientInfo {
    _clientId = @"BtZoBtnOjnUc3tPlkwXs";
    _clientSecret = @"lMfgxMRZUqGItiEmsgTEddWgNTHqWk4R";
    _redirectUrl = @"http://www.travelease.com.cn";
}
```

