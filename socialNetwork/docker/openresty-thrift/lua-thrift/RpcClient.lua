--
----Author: xiajun
----Date: 20151020
----
local TSocket = require "TSocket"
local TSocketSSL = require "TSocketSSL"
local TFramedTransport = require "TFramedTransport"
local TBinaryProtocol = require "TBinaryProtocol"
local THttpTransport = require "THttpTransport"
local TJSONProtocol = require "TJsonProtocol"
local Object = require "Object"

local RpcClient = Object:new({
	__type = 'RpcClient',
})

--初始化RPC连接
function RpcClient:init(ip,port,timeout,ssl)
	if (ssl == true) then
		socket = TSocketSSL:new{
			host = ip,
			port = port
		 }
	else
		socket = TSocket:new{
			host = ip,
			port = port
		}
	end
	socket:setTimeout(timeout)
	local transport = THttpTransport:new{
		trans = socket
	}
	local protocol = TJSONProtocol:new{
		trans = transport
	}
	transport:open()
	return protocol;
end
--创建RPC客户端
function RpcClient:createClient(thriftClient)end

return RpcClient
