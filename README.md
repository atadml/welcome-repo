# Welcome!

## Getting Started

The best way to get started is to try a few sample queries on this welcome project:

- sample SQL prompts - sample_notebook2.sql
- sample LookML prompts - sample_notebook.sql

## Introduction

We call this **DML**. DML is both an IDE as well as a code assistant. It currently supports **SQL** and Google's **LookML** data modeling languages.

DML works best for two sets of tasks:

### 1) Data Architecture and Modeling Questions

<details> 
<summary>Sample Q: generate the model file

```lookml
# ecommerce.model.lkml

include: "users.view.lkml"
include: "orders.view.lkml"
include: "order_items.view.lkml"

explore: users {
  join: orders {
    type: left
    sql_on: ${users.id} = ${orders.user_id} ;;
    relationship: one_to_many
  }
  
  join: order_items {
    type: left
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }
}
....
```

</details>

### 2) Analytical and Business Questions

<details> 
<summary>Sample Q: Give me orders by month with price average in sql</summary>

```sql
SELECT 
    EXTRACT(MONTH FROM o.created_at) AS month,
    EXTRACT(YEAR FROM o.created_at) AS year,
    AVG(oi.sale_price) AS average_order_price
FROM 
    public.orders o
JOIN 
    public.order_items oi ON o.id = oi.order_id
GROUP BY 
    EXTRACT(MONTH FROM o.created_at), EXTRACT(YEAR FROM o.created_at)
ORDER BY 
    year, month

```

</details>

## Organization of the Copilot

DML Copilot exists in two places.

- At Project-wide level

  <img width="544" alt="image" src="https://raw.githubusercontent.com/atadml/welcome-repo/main/images/copilot_project.png">
- At File-specific level

  <img width="215" alt="image" src="https://raw.githubusercontent.com/atadml/welcome-repo/main/images/copilot_file.png">

Examples:

1. You're working on a new use case around functionality that does not currently exist in your data model => **Project-wide level**
2. You want to make changes to your existing model file => **File-specific level**

**Important:**

<span style="color:red;">At the center of **DML** is the idea that you're making changes to the **entire file** every single time. Resulting answer code **automatically overwrites the existing code inside that file**, and further commits it into the remote git repo. **This is by design**</span>

## Writing Prompts

It is important to give a directive to DML about the language you want the answer to be written in. This is done with the **ending words** like this:

- **"in sql"** - will generate sql
- **"in lookml"** - will generate lkml code

## Connecting to GitHub

Alternatively, you can connect your own git-based project. We currently support these inside projects:

- LookML-based files

<img width="348" alt="image" src="https://raw.githubusercontent.com/atadml/welcome-repo/main/images/git1.png">

<img width="302" alt="image" src="https://raw.githubusercontent.com/atadml/welcome-repo/main/images/git2.PNG">

## Additional Resources

- [Benchmark App](https://llmsql.streamlit.app/): Explore our benchmark app to learn more about the reliability of LLM-powered solutions.

If you have further questions, please write to [sg@atad.ml](mailto:sg@atad.ml)
