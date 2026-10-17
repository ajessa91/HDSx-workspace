def summarize_mean_sd(data, value, group1, group2):
    filtered = data.dropna(subset=[value, group1, group2])

    summary = (
        filtered
        .groupby([group1, group2], as_index=False)
        .agg(
            n=(value, "size"),
            mean_value=(value, "mean"),
            sd_value=(value, "std")
        )
        .sort_values([group1, group2])
    )

    summary["mean_value"] = summary["mean_value"].round(2)
    summary["sd_value"] = summary["sd_value"].round(2)

    return summary