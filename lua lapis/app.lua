local lapis = require "lapis"
local app = lapis.Application()
local categories = require 'models.categories'
local products = require 'models.products'

app:get("init ", "/", function(self)
	return {status=200}
end)


app:get("get categories", "/categories", function(self)
	return { json = categories.getCategories(-1), status=200}
end)

app:get("get category", "/categories/:id", function(self)
	-- print("category id: " .. self.params.id)
	return { json = categories.getCategories(tonumber(self.params.id)), status=200}
end)

app:post("add categories", "/categories/add", function(self)
	categories.addCategory(self.params.category_name)
	return {status=200}
end)

app:post("update category", "/categories/update", function(self)
	categories.updateCategory(tonumber(self.params.id), self.params.category_name)
	return {status=200}
end)

app:delete("delete category", "/categories/delete/:id", function(self)
	categories.deleteCategory(tonumber(self.params.id))
	return {status=200}
end)


app:get("get products", "/products", function(self)
	return { json = products.getproducts(-1), status=200}
end)

app:get("get product", "/products/:id", function(self)
	return { json = products.getproducts(tonumber(self.params.id)), status=200}
end)

app:post("add product", "/products/add", function(self)
	products.addProduct(self.params.product_name, self.params.category_id, self.params.price)
	return {status=200}
end)

app:post("update product", "/products/update", function(self)
	products.updateProduct(tonumber(self.params.id), self.params.product_name,
			 self.params.category_id, self.params.price)
	return {status=200}
end)

app:delete("delete product", "/products/delete/:id", function(self)
	products.deleteProduct(tonumber(self.params.id))
	return {status=200}
end)


return app