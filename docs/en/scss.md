# SCSS Layout

The css structure we use is based upon bem (https://en.bem.info/methodology/quick-start/) (http://getbem.com/)

## File Layout

The folder structure should be:

- *scss*:
    - blocks  
        - elements
        - modifiers
    - config  
        - _colours.scss
        - _fonts.scss
        - _grid.scss
        - _mixins.scss
        - _modifiers.scss
        - _retina.scss
        - _sprite.scss
        - _typography.scss
        - _variables.scss
        - pages
        - plugins
  
**Blocks** - Contains all blocks & subsequently any elements & any modifiers.  
**Elements** - Elements of a block. These are elements that __cannot__ exist by themselves outside of their associated block.  
**Modifiers** - Block/element specific modifiers.  
**Config** - Generic, global level configuration.  
**Pages** - Page specific overrides go here __ONLY__ as a last resort (use blocks where possible).  
**Plugins** - Syles supporting javascript plugins.

## Structure

### Block

A block is a stand-alone element. It's an independent component of the page which in theory could be used many times in the same page.  
The block name describes its purpose ("What is it?" — _menu_ or _button_), not its state ("What does it look like?" — _red_ or _big_). (see bem.info)

A block should look like the following:


```scss
/*
 * /blocks/_block-name.scss
 */
.block-name {
	properties ...
}
```


The naming convention is to use hyphen case - e.g.

    block-name

**NOT**

    blockName
    
Good names:

    menu
    main-menu
    footer
    
Bad names:

    red-menu
    black-text
    
The above are bad as they represent **Appearance** rather than **Context**  

----

### Element

An element is _dependent_ upon a parent block.  
It is not intended to be used outside of the block.  
Not all components are elements - only those that cannot live outside of a block.  
The element name describes its purpose ("What is this?" — item, text, etc.), not its state ("What type, or what does it look like?" — red, big, etc.). (see bem.info)

An element should look like the following:

```scss
/*
 * /blocks/_block-name.scss
 */
.block-name {
	@import 'elements/block-name__item';
    ...
}
```

```scss
/*
 * /blocks/elements/_block-name__item.scss
 */
&.__item {
    properties ...
}
```

The name of the element **extends** the block using double underscores "__":

    block-name__item
    block-name__heading
    block-name__aside__item
    
**Note:** the last item is an example of nested elements. Elements may nest infinitely within each other.

**NOT**

    block-name-item
    block-name-red-text
    
The above are bad as they represent **Appearance** rather than **Context**  

----

### Modifiers

An entity that defines the appearance, state, or behavior of a block or element.  
The modifier name describes its appearance ("What size?" or "Which theme?" and so on — size_s or theme_islands), its state ("How is it different from the others?" — disabled, focused, etc.) and its behavior ("How does it behave?" or "How does it respond to the user?" — such as directions_left-top).  
The modifier name is separated from the block or element name by a single underscore (_). (see bem.info)

The name of the modifier **extends** the block or element using a single underscores "_":

    block-name_right-aligned
    block-name_disabled
    block-name__aside_size_large
    
There are **2** types of modifier:

* boolean (a modifier is on or off) - e.g. **block-name_disabled**, **block-name__element_disabled**
* key/value (used when there are variations of a modifier) - e.g. **block-name_size_large**,  **block_name__element_size_small**  
 
**There should only be one key/value modifier ever used on one component at a time.**  

```scss
/*
 * /blocks/modifiers/_modifier-name.scss
 */
&_modifier-name {
    ...
}
``` 

#### Blocks

```scss
/*
 * /blocks/_block-name.scss
 */
.block-name {
    @import 'modifiers/block-name';
	@import 'elements/block-name__item';
    ...
}
```  

#### Elements  

```scss
/*
 * /blocks/elements/_block-name__item.scss
 */
&.__item {
   @include '../modifiers/_block-name__item.scss';
}
```
