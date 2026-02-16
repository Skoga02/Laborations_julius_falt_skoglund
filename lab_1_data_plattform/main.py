import pandas as pd 

# Reads in csv file and separetes columns by ";"
lab_df = pd.read_csv("lab_1.csv", sep=';')

print("Untouched data:")
print(lab_df.head())

# Removes whitespaces start/end, makes first letter capital
lab_df["name"] = lab_df["name"].str.strip().str.replace(r"\s+", " ", regex=True).str.title() # Unclear if there actually is any double whitespaces
lab_df["currency"] = lab_df["currency"].str.strip()

# Fix date format 
lab_df["created_at"] = lab_df["created_at"].str.replace("/", "-", regex=False)

# convert types
lab_df["price"] = pd.to_numeric(lab_df["price"], errors="coerce")
lab_df["created_at"] = pd.to_datetime(lab_df["created_at"], errors="coerce") # Shows the dates that are wrong

# Flagging for errors or simular 
lab_df["missing_currency"] = lab_df["currency"].isna()
lab_df["luxury_products"] = lab_df["price"] > 5000
lab_df["price_zero?!"] = lab_df["price"] == 0


# TODO - this does not avvisa omöjliga värden i kolumner 
lab_df["invalid_price"] = lab_df["price"] < 0
lab_df["missing_id"] = lab_df["id"].isna()
lab_df["missing_name"] = lab_df["name"].isna()
lab_df["invalid_date"] = lab_df["created_at"].isna()

# dosent really reject anything, just points them out. 
rejected_df = lab_df[
    (lab_df["invalid_price"]) |
    (lab_df["missing_id"]) |
    (lab_df["missing_name"])
]

# this actully removes invalid prices
lab_df.loc[lab_df["price"] < 0, "price"] = None

print("Cleaned data:")
print(lab_df)

valid_df = lab_df[~lab_df.index.isin(rejected_df.index)]

####################################
######## analytics summary #########

summary_df = pd.DataFrame({
    "snittpris": [valid_df["price"].mean()],
    "medianpris": [valid_df["price"].median()],
    "antal produkter": [len(valid_df)],
    "antal produkter med saknat pris": [valid_df["price"].isna().sum()]
})

summary_df.to_csv("analytics_summary.csv", index=False)

####################################
######### price analytics ########## 
top_10_expensive = valid_df.sort_values("price", ascending=False).head(10)
top_10_expensive["category"] = "Top 10 expensive"

median_price = valid_df["price"].median()
valid_df["price deviation"] = abs(valid_df["price"] - median_price)

top_10_deviation = valid_df.sort_values("price deviation", ascending=False).head(10)
top_10_deviation["category"] = "Top 10 price deviation"

price_analytics = pd.concat(
    [top_10_expensive, top_10_deviation],
    ignore_index=True
)

columns_to_keep = [
    "id",
    "name",
    "price",
    "price deviation",
    "category"
]

price_analytics = price_analytics[columns_to_keep]

price_analytics.to_csv("price_analytics.csv", index=False)