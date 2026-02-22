import pandas as pd 

############# LOAD ##############
# Reads in csv file and separetes columns by ";"
lab_df = pd.read_csv("lab_1.csv", sep=';')

######## CLEAN & TRANSFORM ########

# Removes whitespaces start/end, makes first letter capital
lab_df["name"] = lab_df["name"].str.strip().str.replace(r"\s+", " ", regex=True).str.title() # Unclear if there actually is any double whitespaces
lab_df["currency"] = lab_df["currency"].str.strip()

# Fix date format 
lab_df["created_at"] = lab_df["created_at"].str.replace("/", "-", regex=False)

# convert types
lab_df["price"] = pd.to_numeric(lab_df["price"], errors="coerce")
lab_df["created_at"] = pd.to_datetime(lab_df["created_at"], errors="coerce") # Impossible dates becomes NaT (Not a Time)

########## FLAGGING, BUSINESS RULES ##########
# Flagging for errors or simular 
lab_df["missing_currency"] = lab_df["currency"].isna()
lab_df["luxury_products"] = lab_df["price"] > 5000
lab_df["price_zero"] = lab_df["price"] == 0

########## VALIDATION ###########

lab_df["invalid_id"] = lab_df["id"].isna() | (lab_df["id"] == "")
lab_df["invalid_name"] = lab_df["name"].isna() | (lab_df["name"] == "")
lab_df["invalid_price"] = lab_df["price"].isna() | (lab_df["price"] < 0)
lab_df["invalid_date"] = lab_df["created_at"].isna()

reject_condition = (
    lab_df["invalid_id"] |
    lab_df["invalid_name"] |
    lab_df["invalid_price"] |
    lab_df["invalid_date"]
)

rejected_df = lab_df[reject_condition].copy()
valid_df = lab_df[~reject_condition].copy()

print("Cleaned data:")
print(lab_df)

columns_to_show = [
    "id",
    "name",
    "price",
    "currency",
    "created_at",
    "invalid_id",
    "invalid_name",
    "invalid_price",
    "invalid_date"
]

print("rejected columns:")
print(rejected_df[columns_to_show])

################# ANALYTICS ###################
######## analytics summary #########

analytics_summary_df = pd.DataFrame({
    "snittpris": [valid_df["price"].mean()],
    "medianpris": [valid_df["price"].median()],
    "antal produkter": [len(valid_df)],
    "antal produkter med saknat pris": [lab_df["price"].isna().sum()]   # lab_df since we have some NaN values otherwise always 0
})

analytics_summary_df.to_csv("analytics_summary.csv", index=False)

####################################
######### price analytics ########## 
median_price = valid_df["price"].median()
valid_df["price deviation"] = (valid_df["price"] - median_price).abs()

top_10_expensive = (
    valid_df
    .sort_values("price", ascending=False)
    .head(10)
    .copy()
)
top_10_expensive["category"] = "Top 10 expensive"

top_10_deviation = (
    valid_df
    .sort_values("price deviation", ascending=False)
    .head(10)
    .copy()
)
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

print("Everything completed")