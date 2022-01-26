import React, {Component} from 'react';

class Products extends Component {

    constructor() {
        super();
        this.state = {
            products: [],
            categories: [],
            menuOpt: 0,
            chosenCategory: "all"
        };
    }

    async handleRequest(url) {
        var result = null;
        result = fetch(url, {
            headers:{
                'Accept': 'application/json',
                'Content-Type': 'application/json',
            },
            method: 'GET',
        }).then(response => { return response.json()})
            .then(responseData => {
                return responseData;
            })
        return result;
    }

    async getProducts() {
        var url = "http://localhost:81/products"
        var response = await this.handleRequest(url);
        let products = [];
        response.data.map(prod => {
            let product = {
                name: prod.name,
                id: prod.id,
                description: prod.description,
                category: prod.category,
                price: prod.price
            };
            products.push(product);
        })
        this.setState({products: products})
    }

    async getCategories() {
        var url = "http://localhost:81/category"
        var response = await this.handleRequest(url);
        let categories = {};
        response.data.map(cat => {
            categories[cat.id] = cat.name;
        })
        this.setState({categories: categories})
    }

    componentDidMount() {
        // this.getProducts2();
        console.log("componentDidMount")
        this.getProducts();
        this.getCategories();
    }

    handleDropdownChange = async e => {
        e.preventDefault();
        console.log("handleDropdownChange")
        console.log(e.target.value)
        if(e.target.value == "all") this.state.menuOpt = 0;
        else this.state.menuOpt = 1;
        this.setState({ chosenCategory: e.target.value });
    }

    render() {
        return (

                <div className="products">

                    {console.log(this.state.categories)}
                    <div>
                        <form>
                            <label htmlFor="categories">wybierz kategorie:</label>
                            <select name="cat" id="cat" onChange={this.handleDropdownChange}>
                                <option value="all">wszysko</option>
                                {Object.keys(this.state.categories).map((key, index) =>(
                                    <option value={this.state.categories[key]}>{this.state.categories[key]}</option>
                                ))}
                            </select>
                        </form>
                    </div>

                    {console.log(this.state.products)}
                    {this.state.menuOpt ==0 &&
                    <ul>
                        {this.state.products.map((product,index) => (
                            <div key={index}>
                                <h3>{product.id}: {product.name}</h3>
                                {product.description}
                                <p>Category: {this.state.categories[product.category]}</p>
                                <h1>tylko {product.price} !!!</h1>
                            </div>
                        ))}
                    </ul>
                    }

                    {this.state.menuOpt ==1 &&
                        <div>
                        <ul>
                            {this.state.products.map((product,index) => (
                                <div>
                                    {this.state.categories[product.category] == this.state.chosenCategory &&
                                            <div key={index}>
                                                <h3>{product.id}: {product.name}</h3>
                                                {product.description}
                                                <p>Category: {this.state.categories[product.category]}</p>
                                                <h1>tylko {product.price} !!!</h1>
                                            </div>
                                    }
                                    </div>
                            ))}
                        </ul>
                        </div>
                    }

                </div>
        )
    }
}

export default Products;