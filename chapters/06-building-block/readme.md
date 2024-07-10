# Chapter 06 - Adding a building block

This chapter is still work in progress 🚧

For now, you can read about building blocks in the [flexible programming model explorer](https://sapui5.hana.ondemand.com/test-resources/sap/fe/core/fpmExplorer/index.html#/buildingBlocks/buildingBlockOverview).

Also, we do accept pull requests 😋

Continue to [Chapter 07 - Adding formatting via CDS annotations](/chapters/07-formatting-via-cds-annotations/)

```xml
<macros:Chart
    id="salesChart"
    header="Sales Data"
    metaPath="@com.sap.vocabularies.UI.v1.Chart"
    contextPath="/Books/sales"
    headerVisible="true" />
```

```cds
annotate CatalogService.Sales with @(

    Analytics.AggregatedProperty #sum: {
        Name                : 'sumSales',
        AggregationMethod   : 'sum',
        AggregatableProperty: 'price',
        ![@Common.Label]    : 'Sum Sales'
    },

    Aggregation.ApplySupported       : {
        Transformations         : [
        'aggregate',
        'topcount',
        'bottomcount',
        'identity',
        'concat',
        'groupby',
        'filter',
        'expand',
        'top',
        'skip',
        'orderby',
        'search'
        ],
        CustomAggregationMethods: ['Custom.concat'],
        Rollup                  : #None,
        PropertyRestrictions    : true,
        GroupableProperties     : [month],
        AggregatableProperties  : [{Property: price}]
    },

    UI.Chart: {
        $Type              : 'UI.ChartDefinitionType',
        Title              : 'Chart Title',
        Description        : 'Chart Description',
        ChartType          : #Column,
        DynamicMeasures    : ['@Analytics.AggregatedProperty#sum'],
        Dimensions         : [month],
        MeasureAttributes  : [{
        $Type         : 'UI.ChartMeasureAttributeType',
        DynamicMeasure: '@Analytics.AggregatedProperty#sum',
        Role          : #Axis1
        }],
        DimensionAttributes: [{
        $Type    : 'UI.ChartDimensionAttributeType',
        Dimension: month,
        Role     : #Category
        }]
    }
    
);
```
