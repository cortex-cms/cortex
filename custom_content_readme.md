# Custom Content ReadMe

## Table of Contents
- [Custom Content](#custom-content)
  - [Purpose of Custom Content](#custom-content-purpose)
  - [Vocabulary](#vocabulary)
  - [Creating a New Content Type](#creating-a-new-content-type)
  - [Creating a New Content Item](#creating-a-new-content-item)
  - [Creating a New Field Type](#creating-a-new-field-type)
  - [Creating a New Field](#creating-a-new-field)
     - [Metadata](#metadata)
         - [Text Field Type Metadata](#text-field-type-metadata)
         - [Tree Field Type Metadata](#tree-field-type-metadata)

### Purpose of Custom Content
Custom content types enable administrators and developers to compose content structures out of predetermined FieldTypes and with appropriate validations.

### Vocabulary
<dt>ContentType</dt> <dd>An ordered collection of Fields which represents a category of content that you want on your site</dd>

<dt>Field</dt> <dd>The association between a ContentType and a FieldType. It tells the ContentType which FieldType to use, the validations you want to run on the content when saving this Field, and the order in which the Field is displayed</dd>

<dt>FieldType</dt> <dd>Describes the characteristics of some piece of data that can be used to compose a ContentType. For example, if a ContentType needs a string of text, that would be a TextFieldType, a pdf would be a DocumentFileFieldType, and so on.</dd>

<dt>ContentItem</dt> <dd>An instance of a ContentType, it is a piece of content that gets saved to the database (i.e. a blog post). It consists of multiple FieldItems. ContentItem:FieldItem::ContentType:Field</dd>

<dt>FieldItem</dt> <dd>Each FieldItem represents a component of the ContentItem to which it belongs. So if the ContentItem is a blog post, there would be a FieldItem for the title, another for the body, another for an associated image, etc.</dd>


### Creating a New Content Type
Say you want to create a ContentType called AwesomeBlogPost that has 4 fields: a Title (TextFieldType), a Body (TextFieldType), a Video (YoutubeFieldType), and an Image (ImageFileFieldType).

Each FieldType has a number of validations that can potentially be run. You choose which validations to use when creating a Field using that FieldType. The Field will store the name you specify, the validations you choose to run, and the position of that Field relative to other Fields in the same ContentType.

So, in AwesomeBlogPost you would specify that the Field named "Title" is a TextFieldType which comes first, its presence is required, and it should be a maximum of 50 characters; the Field named "Body" is a TextFieldType which comes second and should have a maximum of 1000 characters; the Field named "Video" is a YoutubeFieldType which comes third; and the Field named "Image" is an ImageFileFieldType which comes last and must be a jpg under 1MB.

```
ct = ContentType.new(name: "AwesomeBlogPost", description: "The kind of blog post that goes on my Awesome Site", creator_id: 1)

ct.fields.new(name: "Title", field_type: "text_field_type", order_position: 1, validations: { presence: true, length: { maximum: 50 } }, metadata: { placeholder: "This is the title" })

ct.fields.new(name: "Body", field_type: "text_field_type", order_position: 2, validations: { length: {maximum: 1000 } })

ct.fields.new(name: "Video", field_type: "youtube_field_type", order_position: 3, validations: {})

ct.fields.new(name: "Image", field_type: "image_file_field_type", order_position: 4, validations: content_type: { content_type: "image/jpeg" }, size: { less_than: 1.megabyte })

ct.save
```

### Creating a New Content Item
A ContentItem is composed of FieldItems. A ContentItem represents the actual content that writers create. When a user creates a blog post of type AwesomeBlog, the content she inputs for each Field is stored in a corresponding FieldItem as 'data.'

### Validations
Each FieldType defines the validations that can be run on a FieldItem's data. It should have a hash where the keys are the different types of validations that can be run, and the values are method names that will be called to determine if the requested Field validation is legitimate:
```
VALIDATION_TYPES = {
  length: :valid_length_validation?,
  presence: :valid_presence_validation?
}.freeze
```

In order to define the validations that can be run, we use the [validators defined by Rails](https://github.com/rails/rails/tree/master/activemodel/lib/active_model/validations). You can also write [custom validators](http://guides.rubyonrails.org/active_record_validations.html#custom-validators) that would be used in the same way. This makes it easy to adhere to the same syntax used with ActiveRecord validations. When creating a Field, first it checks to ensure that the requested validations are consistent with the validations its FieldType provides, e.g. if a TextFieldType supports presence and length validations, you will not be able to add a numericality validation. Then the FieldType tests to see that any requested Field validations are allowed by instantiating the associated Validator and catching any ArgumentError or NoMethodError that gets thrown. If an error is thrown, then the syntax or content of the Field validation is incorrect somehow. If there is no error, then the Field validation is allowed.

The Field validations themselves are run when creating a ContentItem and its associated FieldItems. A ContentItem is only considered valid if all of its FieldItems are valid. To determine validity, the FieldItem instantiates the FieldType, passes in its data, and tells the FieldType to run the validations hash specified by the Field.

```
class TextFieldType
  def text_length
    validator = LengthValidator.new(validations[:length].merge(attributes: [:text]))
    validator.validate_each(self, :text, text)
  end
end
```

### Creating a New Field Type
A FieldType must keep track of the sorts of validations it can run and be able to run all or a subset of those validations on the data passed to it (namely, the data in a field item). It must also be able to check that the validations given it are ones that Rails validators can actually run. The file name for a new FieldType should end in '_field_type.rb'

### Creating a New Field
Some stuff about Fields, fields have metadata.

### Metadata
Metadata encompasses information about fields that don't necessarily fit under any of the other attributes. Metadata is entered by the User creating the Content Type.

#### Text Field Type
Typically for Text Field Types, the metadata will allow the User creating the field to specify display properties. The most common example of this is probably the use of Placeholder text. It will typically only be passing a String.

```
ct.fields.new(
    name: "Title", 
    field_type: "text_field_type", 
    order_position: 1,
    metadata: { placeholder: "This is the title" }
)
```

#### Tree Field Type
Tree Field Types depend fairly heavily on metadata, the metadata in Tree Field Types enumerates the structure for hierarchical data. As an Admin this metadata is used to specify the ```allowed_values``` a User can select, any selections made will then be validated against what was specified in ```allowed_values```.

The Tree Field Type can be used in two fairly different ways: To represent simple lists / dropdown selections and also to represent hierarchical data structures. The expected values as well as simple exmaples are below:

__Simple Lists__

A Simple list is any data that would go into a Dropdown in the view, these items do not need to necessarily relate to one another, but could have a general theme in common. Below we have a simple image to illustrate this:

![Simple List Image](https://cloud.githubusercontent.com/assets/8419757/16248100/b023e68a-37d2-11e6-97df-187c2c07fb33.png)

And the data representation of this list:

```ruby
{
  :allowed_values => [
     { :name => "Art", :id => 1, :children => [] },
     { :name => "Computers", :id => 2, :children => [] },
     { :name => "Management", :id => 3, :children => [] },
   	 { :name => "Action", :id => 4, :children => [] }
  ]
}
```

__Hierarchical Data__

A good example of actual Tree based data structures would be a family tree, below we have a family tree of House Stark form popular ficton to illustrate:

![House Stark Image](https://cloud.githubusercontent.com/assets/8419757/16248101/b4135118-37d2-11e6-815c-e42262c47e63.png)

And the data representation of this tree:

```ruby
{
  :allowed_values => [
    {
      :name => "Rickon Stark", :id => 1, :children => [
        { :name => "Brandon Stark", :id => 2, :children => [] },
        { :name => "Eddard Stark", :id => 3, :children => [
          	{ :name => "Robb Stark", :id => 6, :children => [] },
          	{ :name => "Sansa Stark", :id => 7, :children => [] },
          	{ :name => "Arya Stark", :id => 8, :children => [] },
          	{ :name => "Bran Stark", :id => 9, :children => [] },
          	{ :name => "Rickon Stark II", :id => 10, :children => [] },
          ]
   		 },
   		 { :name => "Lyanna Stark", :id => 4, :children => [
   		 		{ :name => "Jon Snow", :id => 11, :children => [] },
   		 	]
   		 },
   		 { :name => "Benjen Stark", :id => 5, :children => [] }
      ]
    }
  ]
}
```


