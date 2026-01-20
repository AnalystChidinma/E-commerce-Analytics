### E-commerce Analytics Engineering with dbt & Snowflake (Olist Dataset)

## Project Overview

This project is an end-to-end analytics engineering pipeline built using dbt Cloud and Snowflake, leveraging the Olist Brazilian E-commerce dataset.

The goal of the project is to transform raw e-commerce data into clean, well-modeled, analytics-ready tables that support reliable analysis of customer behavior, order performance, revenue, and delivery operations.

The project follows modern analytics engineering best practices, including layered data modeling, version control with GitHub, and warehouse-native transformations.


## 📊 Dataset Overview

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**About the Data:**
- 100k orders from 2016 to 2018
- Multiple marketplaces in Brazil
- Real commercial data anonymized
- Complete order lifecycle including payments, reviews, and logistics

**Raw Tables:**
- `olist_customers` - Customer information and location
- `olist_orders` - Order status and timestamps
- `olist_order_items` - Items within orders
- `olist_order_payments` - Payment transactions
- `olist_order_reviews` - Customer reviews and ratings
- `olist_products` - Product catalog
- `olist_sellers` - Seller information

## Tech Stack

 - Data Warehouse: Snowflake

 - Transformation Tool: dbt Cloud

 - Version Control: GitHub

 - Development Environment: VS Code

 - Data Source: Olist public dataset (CSV files)

### Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/uforodavid/dbt_bootcamp.git
cd dbt_bootcamp
```

2. **Set up dbt**
```
1. Create a dbt Cloud account
2. Create a new dbt Cloud project
3. Connect the project to the GitHub repository
4. Configure a Snowflake data warehouse connection
5. Set the deployment environment (dev target)

```

3. **configured Warehouse connection**
```
1. Navigate to the dbt Cloud project settings
2. Open the Environment configuration (e.g., Dev)
3. Configure the Snowflake connection credentials
4. Assign the target database, warehouse, and schema

```
To validate that the warehouse connection is working correctly, run: ` dbt debug`

5. **Load raw data into Snowflake**
```bash
dbt seed
```
to load datasets into your datawarehouse


## 📈 Expected Outcomes

By completing this project, I will be able to:
- Understand dbt fundamentals and best practices
- Build a production-ready dimensional model
- Implement comprehensive testing and documentation
- Create business-ready analytical models
- Learn performance optimization techniques
- Gain hands-on experience with real-world data scenarios

## Project Architecture
```
seeds/
├── Raw CSV files (Olist dataset)

models/
├── staging/olist
│   ├── stg_olist_customers.sql
│   ├── stg_olist_orders.sql
│   ├── stg_olist_order_items.sql
│   ├── stg_olist_order_payments.sql
│   └── source and schema definitions
│
├── intermediate/transformed
│   ├── int_olist_customers.sql
│   ├── int_olist_orders_enriched.sql
│   ├── int_olist_order_items.sql
│   ├── int_olist_order_payments.sql
│   └── int_order_financials.sql
│
└── mart/core
    ├── dim_customer.sql
    ├── dim_delivery.sql
    ├── fact_orders.sql

```
## DAG & Data Lineage Overview
<img width="719" height="587" alt="dbt lineage" src="https://github.com/user-attachments/assets/f9c9bc07-08bf-4f24-8752-54cd46e8208e" />

## Analytical Use Cases

Using the mart models fact_orders, dim_customers, dim_delivery, analysts can answer questions such as:

 - Which customer locations (state and city) generate the highest revenue?

 - What is the average order value by customer segment?

 - How long do deliveries take, and how often are orders delivered late?

 - How do delivery delays impact order completion status?
 - 
These questions are answered downstream through BI tools or ad-hoc SQL, leveraging the curated tables produced by this project.

### Packages

Recommended dbt packages (in `packages.yml`):

```yaml
packages:
  - package: dbt-labs/dbt_utils
    version: 1.1.1
  - package: calogica/dbt_expectations
    version: 0.10.0
  - package: dbt-labs/codegen
    version: 0.12.0
```

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Olist for providing the public dataset
- dbt Labs for the amazing transformation framework
- Young Data Professionals community for continuous learning and sharing

