# Chapter 08 - Adding value help via CDS annotations

By the end of this chapter, we will have added value help to our application.

## Steps

- [1. Add CDS annotations for `Authors` value help](#1-add-cds-annotations-for-authors-value-help)<br>
- [2. Test value help on list report page](#2-test-value-help-on-list-report-page)<br>
- [3. Add CDS annotations for draft support](#3-add-cds-annotations-for-draft-support)<br>
- [4. Test value help on object page](#4-test-value-help-on-object-page)<br>
- [5. Add CDS annotations to display `name` instead of `ID`](#6-add-cds-annotations-to-display-name-instead-of-id)<br>
- [6. Test value help on object page (again)](#7-test-value-help-on-object-page-again)<br>
- [7. Further questions to discuss](#8-further-questions-to-discuss)<br>

## 1. Add CDS annotations for `Authors` value help

Similar to how we used CDS annotations to add certain formatting to our application (see [previous chapter](/chapters/07-formatting-via-cds-annotations)), we can use CDS annotations to add value help to filters and selection fields.

➡️ Add the following code to the `app/bookshop-ui/annotations.cds` file:

```cds
// value help for Authors
annotate CatalogService.Books with {
    author 
    @Common.ValueListWithFixedValues : true // dropdown instead of dialog
    @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Authors',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : author_ID,
                ValueListProperty : 'ID',
            }
        ]
    }
};

// value help for Authors: display name instead of ID
annotate CatalogService.Authors with {
    ID @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};
```

We added two blocks of CDS annotations to our application that serve two purposes:
1. The first block annotates the `author` of the `Books` entity. It makes sure that the value help is displayed as a dropdown menu (instead of a pop-up dialog) and that the `author_ID` does in fact point to the `ID` of the `Author` entity.
2. The second block then annotates the `Author` entity and makes sure that inside the value help the `name` is displayed instead of the `ID`.

## 2. Test value help on list report page

➡️ (Re)visit the URL of the SAP CAP server and refresh the page. Test the value help for `Authors` on the list report page:

![list report page](list-report-page.png)

## 3. Add CDS annotations for draft support

Before we can implement and test the value help on the object page as well, we have to make the `Books` entity editable via draft support.

The SAP Cloud Application Programming Model comes with built in support for drafts via the `@odata.draft.enabled` annotation. SAP Fiori elements applications will only display the CREATE and EDIT buttons for the respective entity if this annotation is set. With draft support in place, user sessions are stored on the server, so they can interrupt and continue later on, possibly from different places and devices.

➡️ Add the following code to the `app/bookshop-ui/annotations.cds` file:

```cds
annotate CatalogService.Books with @odata.draft.enabled;
```

We enabled draft support for the `Books` entity, which allows us to create new books and edit existing ones.

## 4. Test value help on object page

Let's test the draft support by creating a new book.

➡️ (Re)visit the URL of the SAP CAP server and refresh the page. Click "Create" on the list report page and enter some random data on the object page:

![object page](object-page.png)

This doesn't look too bad, but the `Author` field displays the `author_ID` instead of the `name` once a value is selected. Let's fix that.

## 5. Add CDS annotations to display `name` instead of `ID`

➡️ In the `app/bookshop-ui/annotations.cds` file, replace the annotations for the `Author` and `Genre` data fields within the `UI.FieldGroup #GeneratedGroup1` with the following code:

```cds
            {
                $Type : 'UI.DataField',
                Label : 'Author',
                Value : author_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Genre',
                Value : genre_ID,
            },
```

We modified the annotations so that the "General Information" field group now points to the `author_ID` and `genre_ID` instead of `author.name` and `genre.name`. This might sound counterintuitive, but we will now define a different `@title` annotation for the `author` and `genre` fields now. For those to take effect, we need the annotation to point to the linking field, which is the `author|genre_ID`. 

➡️ In the `app/bookshop-ui/annotations.cds` file, replace the section labeled `general` (via a comment) with the following code:

```cds
// general
annotate CatalogService.Books with {
    title @title : 'Title';
    descr @title : 'Description';
    author @title: 'Author' @Common: { Text: author.name, TextArrangement: #TextOnly };
    genre @title: 'Genre' @Common: { Text: genre.name, TextArrangement: #TextOnly };
    price @title: 'Price';
    stock @title: 'Stock';
}
```
We modified the CDS annotations containing the titles for the fields of the `Books` entity. We also added details about the text that should be displayed for certain fields.

## 6. Test value help on object page (again)

➡️ (Re)visit the URL of the SAP CAP server and refresh the page. On the list report page, click "Create" and test the value help on the object page. You should see the `name`s for author and genre (instead of `ID`s) and you should be able to create the book:

![app](app.png)

### 7. Further questions to discuss

➡️ If you happen to finish this chapter early, think about the following questions (that we will discuss later):

- In step 6 we added annotations that make sure the `name`s are displayed for the author and genre on the list report page. We did something similar in step 1 as well - what is the difference?
- How do you personally like the experience using annotations so far? (There is no right or wrong answer to this question.)

Continue to [Chapter 09 - Adding a header section via CDS annotations](/chapters/09-header-section-via-cds-annotations/)
