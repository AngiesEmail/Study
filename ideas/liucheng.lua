-- 1、AppDelegate.cpp 
-- local c = {2,3,4,5,1,87,33,22}

-- print(unpack(c))
--可以直接把表打出来 全部

-- local c1 = {"a","b","c"}
-- local c2 = {a=1,b=3,c=6}
-- print(unpack(c,4))
--打出表的一部分 4代表打出的个数
--unpack 可以返回多这个值，传入一个array，然后返回array中的每一个值
--unpack的一个重要用法是泛型调用，如果想调用一个函数f，传入可变数量的参数。
-- f(unpack(c))
-- f = string.len
-- a = {"hello","11"}
-- print(unpack(a))
-- print(f(unpack(a)))
--返回所有参数
-- function id( ... )
-- 	return ... 
-- end

-- print(id(2,3,4,5,1,"ee"))
--实现跟踪函数调用
-- function foo( ... )
-- 	return ...
-- end

-- function fool( ... )
-- 	print("calling foo:",...)
-- 	return foo(...)
-- end

-- print(fool(1,2,3,4,"ee"))
--自己跟踪自己的类
	--以何种方式提供有关函数执行和类操作的调试信息，通过log来分析程序的问题所在。
-- function test(config_name, ... )
-- 	if config_name then
-- 		print(config_name)
-- 	end
-- 	--可变参数 可打印出可变参数的个数
-- 	print(arg.n)
-- end

-- test("setting",1,2)
--读取文件
-- local config_path = AppInformation:getInstance():getRealFileName("config/"..config_name .. ".json",'config')

-- function Mediator:mapEventListener(dispatcher, type,  target , func, priority)
--     self:getEventMap():mapListener(dispatcher, type,  target , func, priority)
-- end
-- self:mapEventListener( GetEventDispatcher(self:getBtn("close2")) ,TOUCH_EVENT_CLICK_ACCURATE,self,self.onClose)
-- 第一个是事件的接收者，事件的调度者 dispatcher 监听者 接收事件 通过button来监听事件
-- 第二个是事件的类型 
-- 第三个是事件触发按钮所属target
-- 第四个是调用的事件
-- 第五个是优先级
--跟踪函数 连接
-- http://blog.chinaunix.net/uid-26611383-id-3637565.html































