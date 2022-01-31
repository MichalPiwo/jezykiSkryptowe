local lapis = require "lapis"
local app = lapis.Application()

local products = 
	{
		{
			id = 0,
			name = "mleko",
			kategoria_id = "0",
			cena = "2.99"
		},
		{
			id = 1,
			name = "mydlo",
			kategoria_id = "1",
			cena = "9.99"
		},
	}

function products:addNewProduct(n, k, c)
  products[#products+1] = {
    	id = #products+1,
		name = n,
		kategoria_id = k,
		cena = c
  }
  return #products -- returns player id
end

local categories = 
	{
		{
			id = "0",
			name = "jedzenie"
		},
		{
			id = "1",
			name = "pielegnacja"
		}
	}

app:get("init ", "/", function(self)
  	return {status=200}
end)

app:get("get products", "/products", function(self)
	local ret = products
  	return { json = ret, status=200}
end)

app:post("add product", "/product", function(self)
	print("!!!!!!!!!!!!!!!!!")

	-- last_prod_id = last_prod_id + 1
	-- print(last_prod_id)
	print(self.params.name)
	print(self.params.kategoria_id) 
	print(self.params.cena) 

	-- local prod =  {id = last_prod_id, name = self.params.name, 
	-- 				kategoria_id = self.params.kategoria_id, cena = self.params.cena}
	local new_id = products:addNewProduct(self.params.name, self.params.kategoria_id, self.params.cena)

	-- print(prod["id"])
	-- products[last_prod_id] = prod
	-- table.insert(products, prod)
	print("dodany produkt")
	print(products[new_id]["id"])
	print(products[new_id]["name"])
	print(products[new_id]["kategoria_id"])
	print(products[new_id]["cena"])
	print("!!!!!!!!!!!!!!!!!")
 	return {status=200}
end)

app:get("get categories", "/categories", function(self)
  	return { json = categories, status=200}
end)

return app