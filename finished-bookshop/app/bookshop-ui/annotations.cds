using CatalogService as service from '../../srv/cat-service';

// general
annotate CatalogService.Books with {
    title   @title: 'Title';
    descr   @title: 'Description';
    author  @title: 'Author'  @Common: {
        Text           : author.name,
        TextArrangement: #TextOnly
    };
    genre   @title: 'Genre'   @Common: {
        Text           : genre.name,
        TextArrangement: #TextOnly
    };
    price   @title: 'Price';
    stock   @title: 'Stock';
}

annotate CatalogService.Books with @(
    UI                            : {
        SelectionFields: [
            genre_ID,
            author_ID
        ],
        HeaderInfo     : {
            TypeName      : 'Book',
            TypeNamePlural: 'Books',
            Title         : {Value: title},
            Description   : {Value: author.name}
        },
        Identification : [{Value: ID}],
        LineItem       : {
            $value            : [
                {
                    $Type            : 'UI.DataField',
                    Value            : title,
                    ![@UI.Importance]: #High
                },
                {
                    $Type            : 'UI.DataField',
                    Value            : author.name,
                    Label            : 'Author',
                    ![@UI.Importance]: #High
                },
                {
                    $Type            : 'UI.DataField',
                    Value            : genre.name,
                    Label            : 'Genre',
                    ![@UI.Importance]: #Medium
                },
                {
                    $Type            : 'UI.DataField',
                    Value            : price,
                    ![@UI.Importance]: #Medium
                },
                {
                    $Type                    : 'UI.DataField',
                    Value                    : stock,
                    Criticality              : criticality,
                    CriticalityRepresentation: #WithoutIcon,
                    ![@UI.Importance]        : #Medium
                }
            ],
            ![@UI.Criticality]: criticality // criticality for whole line item
        }
    },
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Value: descr,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Author',
                Value: author_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Genre',
                Value: genre_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: stock,
            },
            {
                $Type: 'UI.DataField',
                Value: price,
            },
        ],
        Label: 'General Information',
    },
    UI.Facets                     : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'General Information',
        ID    : 'GeneratedFacet1',
        Target: '@UI.FieldGroup#GeneratedGroup1',
    }, ],
    UI.DataPoint #stock           : {
        Value      : stock,
        TargetValue: 100,
        Criticality: criticality
    },
    UI.Chart #stock               : {
        ChartType        : #Donut,
        Title            : 'Stock',
        Measures         : [stock, ],
        MeasureAttributes: [{
            DataPoint: '@UI.DataPoint#stock',
            Role     : #Axis1,
            Measure  : stock,
        }, ],
    },
    UI.HeaderFacets               : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'stock',
        Target: '@UI.Chart#stock',
    }, ],
);

annotate CatalogService.Sales with @(

    UI.Chart                         : {
        $Type              : 'UI.ChartDefinitionType',
        ChartType          : #Line,
        DynamicMeasures    : ['@Analytics.AggregatedProperty#sum'],
        MeasureAttributes  : [{
            $Type         : 'UI.ChartMeasureAttributeType',
            DynamicMeasure: '@Analytics.AggregatedProperty#sum',
            Role          : #Axis1
        }],
        Dimensions         : [date],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: date,
            Role     : #Category
        }]
    },

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
            'top',
            'skip',
            'orderby',
            'search'
        ],
        CustomAggregationMethods: ['Custom.concat'],
        Rollup                  : #None,
        PropertyRestrictions    : true,
        GroupableProperties     : [date],
        AggregatableProperties  : [{Property: price}]
    }

);

// value help for Authors
annotate CatalogService.Books with {
    author
    @Common.ValueListWithFixedValues: true // dropdown instead of dialog
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Authors',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: author_ID,
            ValueListProperty: 'ID',
        }]
    }
};

// value help for Authors: display name instead of ID
annotate CatalogService.Authors with {
    ID @Common.Text: {
        $value                : name,
        ![@UI.TextArrangement]: #TextOnly,
    }
};

annotate CatalogService.Books with @odata.draft.enabled;
