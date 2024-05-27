print("Before continuing, make sure your 2 proxmox hosts are already in a cluster")


function yes_or_no()
	local answer
	repeat
		io.write("Please answer with y for yes, or n for no: ")
		io.flush()
		answer=io.read()
	until answer=="y" or answer=="n"

	if answer == "y" then
		return true
	else
		return false
	end
end

function get_input(question)
	io.write(question)
	io.flush()
	return io.read()
end

function execute_return(command)
	local fp = assert(io.popen(command, "r"))
	local output = fp:read("*all")
	fp:close()
	return(output)
end


print("Before continuing, make sure your 2 proxmox hosts are already in a cluster")
get_input("Press enter to continue")
print("")
local qdevip = get_input("Please enter the IP of the device docker: ")
local qdevport = get_input("Please enter ssh port for the qdevice instance (default 2222): ")
local node1ip = get_input("Please enter the IP of the first proxmox node: ")
local node2ip = get_input("Please enter the IP of the second proxmox node: ")


local failed = false
print("Testing qdevice ssh...")
if execute_return("nc -w 1 -v " .. qdevip .. " " .. qdevport .. " &> /dev/null; echo $?"):sub(1,1) ~= 0 then
	print("Test passed")
else
	print("Test failed")
	failed = true
end	

print("Testing node 1 ssh...")
if execute_return("nc -w 1 -v " .. node1ip .. " 22 &> /dev/null; echo $?"):sub(1,1) ~= 0 then
	print("Test passed")
else
	print("Test failed")
	failed = true
end	

print("Testing node 2 ssh...")
if execute_return("nc -w 1 -v " .. node2ip .. " 22 &> /dev/null; echo $?"):sub(1,1) ~= 0 then
	print("Test passed")
else
	print("Test failed")
	failed = true
end	

if failed then
	print("setup failed, exiting")
	os.exit()
end

print("Adding SSH keys from node 1 to local ssh config")
execute_return("ssh-keyscan " .. node1ip .. " >> ~/.ssh/known_hosts")

print("Adding SSH keys from node 2 to local ssh config")
execute_return("ssh-keyscan " .. node2ip .. " >> ~/.ssh/known_hosts")

print("You need to add the SSH pubkey to node 1 with : ")
print("ssh-keyscan -p " ..  qdevport .. " " .. qdevip .. " | tee -a ~/.ssh/known_hosts")
print("")
print("Would you like to try to add it through the script?")
print("If not run, the command manually through SSH or the web console")
print("The login will be as root")

if yes_or_no() then
	execute_return("ssh -t root@" .. node1ip .. " \"/usr/bin/ssh-keyscan -p " ..  qdevport .. " " .. qdevip .. " | tee -a ~/.ssh/known_hosts\"")
end

print("You need to add the SSH pubkey to node 2 with : ")
print("ssh-keyscan -p " ..  qdevport .. " " .. qdevip .. " | tee -a ~/.ssh/known_hosts")
print("")
print("Would you like to try to add it through the script?")
print("If not run, the command manually through SSH or the web console")
print("The login will be as root")

if yes_or_no() then
	execute_return("ssh -t root@" .. node2ip .. " \"/usr/bin/ssh-keyscan -p " ..  qdevport .. " " .. qdevip .. " | tee -a ~/.ssh/known_hosts\"")
end


