local lapis = require "lapis"
local app = lapis.Application()
local categories = require 'models.categories'

print("hello from app lua")
print("hello from app lua")
print("hello from app lua")

app:get("init ", "/", function(self)
	return {status=200}
end)


app:get("get categories", "/categories", function(self)
	return { json = categories.getCategories(), status=200}
end)


app:post("get categories", "/categories", function(self)
	categories.addCategory(self.params.kategoria)
	return {status=200}
end)


return app