/*
 *  SCDataDefinition.h
 *  Sensible TableView
 *  Version: 5.2.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. YOU SHALL NOT DEVELOP NOR
 *	MAKE AVAILABLE ANY WORK THAT COMPETES WITH A SENSIBLE COCOA PRODUCT DERIVED FROM THIS 
 *	SOURCE CODE. THIS SOURCE CODE MAY NOT BE RESOLD OR REDISTRIBUTED ON A STAND ALONE BASIS.
 *
 *	USAGE OF THIS SOURCE CODE IS BOUND BY THE LICENSE AGREEMENT PROVIDED WITH THE 
 *	DOWNLOADED PRODUCT.
 *
 *  Copyright 2011-2015 Sensible Cocoa. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import <Foundation/Foundation.h>

#import "SCPropertyDefinition.h"
#import "SCPluginUtilities.h"

@class SCDataStore;


/****************************************************************************************/
/*	class SCDataDefinition	*/
/****************************************************************************************/ 
/**	
 This class functions as a means to further extend the definition of user-defined data structures, such as classes and Core Data entities. This enables the framework to automatically generate user interfaces that accurately resemble these structures.
 
 'SCDataDefinition' mainly consists of one or more property definitions of type SCPropertyDefinition. The property definitions can be placed in one or more property groups that will control how the properties are grouped when the user interface is generated. If no property groups are assigned, all property definitions are placed in a single defaultPropertyGroup.
 
 See also: SCClassDefinition, SCDictionaryDefinition, SCEntityDefinition, SCWebServiceDefinition
 
 @warning This is an abstract base class and should never be directly instantiated.
 */
@interface SCDataDefinition : NSObject <SCibInitialization>
{
    NSMutableArray *propertyDefinitions;
    NSString *keyPropertyName;
	NSString *titlePropertyName;
	NSString *titlePropertyNameDelimiter;
	NSString *descriptionPropertyName;
	   
    SCPropertyGroup *defaultPropertyGroup;
    SCPropertyGroupArray *propertyGroups;
    
    BOOL requireEditingModeToEditPropertyValues;
}

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Configuration
//////////////////////////////////////////////////////////////////////////////////////////

/** When set to TRUE, the generated user interface elements are required to be placed in 'Editing Mode' before the user can modify the generated property controls' values. When not in Editing Mode, all the generated property controls will be put in a read-only state. If the UI was automatically generated by the framework, an 'Edit' button will also be automatically added to the navigation bar. Default: FALSE. */
@property (nonatomic, readwrite) BOOL requireEditingModeToEditPropertyValues;

/** The property name that is used to sort the data whenever sorting is requested. */
@property (nonatomic, copy) NSString *keyPropertyName;

/**	The name of the title property for the data structure. 
 
 Title properties are used in user
 interface elements to display title information based on the value of the property
 named here. By default, 'SCDataDefinition' sets this property to the name of the 
 first property. 
 @note To have the title set to more than one property value,
 separate the property names by a semi-colon (e.g.: @"firstName;lastName"). When displayed, the
 titles will be separated by the value of the titlePropertyNameDelimiter property. 
 */
@property (nonatomic, copy) NSString *titlePropertyName;

/** The delimiter used to separate the titles specified in titlePropertyName. Default: @" ". */
@property (nonatomic, copy) NSString *titlePropertyNameDelimiter;

/**	The name of the description property for the data structure. 
 
 Description properties are used in user
 interface elements to display description information based on the value of the property
 named here. 
 */
@property (nonatomic, copy) NSString *descriptionPropertyName;

/** The set of cell action blocks that will be assigned to all cells generated by the definition's properties. */
@property (nonatomic, readonly) SCCellActions *cellActions;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Managing Property Definitions
//////////////////////////////////////////////////////////////////////////////////////////

/** The number of property definitions. */
@property (nonatomic, readonly) NSUInteger propertyDefinitionCount;

/** Methods adds a new property definition.
 *	@param propertyName The name of the property.
 *	@param propertyTitle The title of the property. If no value is provided, the method automatically generates a user friendly name for the property.
 *	@param propertyType The property type.
 *	@return Returns TRUE if adding the definition was successful. The main reason for addition failure is if the property name does not match an existing property in the data structure.
 */
- (BOOL)addPropertyDefinitionWithName:(NSString *)propertyName 
								title:(NSString *)propertyTitle
								 type:(SCPropertyType)propertyType;

/** Methods adds a new property definition.
 *	@param propertyDefinition The property definition to be added.
 *	@return Returns TRUE if adding the definition was successful. The main reason for addition failure is if the property name does not match an existing property in the data structure (not required if property definition is an SCCustomPropertyDefinition).
 */
- (BOOL)addPropertyDefinition:(SCPropertyDefinition *)propertyDefinition;

/** Methods inserts a new property definition at the given index.
 *	@param propertyDefinition The property definition to be added.
 *	@param index The index to insert the property definition at. Must be less than propertyDefinitionCount.
 *	@return Returns TRUE if inserting the definition was successful. The main reason for insertion failure is if the property name does not match an existing property in the data structure (not required if property definition is an SCCustomPropertyDefinition).
 */
- (BOOL)insertPropertyDefinition:(SCPropertyDefinition *)propertyDefinition
						 atIndex:(NSInteger)index;

/** Removes the property definition at the given index.
 *	@param index Must be less than the total number of property definitions. 
 */
- (void)removePropertyDefinitionAtIndex:(NSUInteger)index;

/** Removes the property definition with the given name. 
 *	@param propertyName The name of the property to be removed. 
 */
- (void)removePropertyDefinitionWithName:(NSString *)propertyName;

/** Returns the property definition at the given index.
 *	@param index Must be less than the total number of property definitions. 
 */
- (SCPropertyDefinition *)propertyDefinitionAtIndex:(NSUInteger)index;

/** Returns the property definition with the given name. 
 *	@param propertyName The name of the property whose definition to be returned. 
 */
- (SCPropertyDefinition *)propertyDefinitionWithName:(NSString *)propertyName;

/** Returns the index for the property definition with the given name. 
 *	@param propertyName The name of the property whose index to be returned. 
 */
- (NSUInteger)indexOfPropertyDefinitionWithName:(NSString *)propertyName;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Managing Property Definition Groups
//////////////////////////////////////////////////////////////////////////////////////////

/** The default property group. The framework will automatically add any properties not included in any other group to this group. If this group has any properties at the time the user interface is generated, it will be rendered as the first group, ahead of all other groups in propertyGroups. 
 *  @note The order of the properties automatically added to this group is the same as their order in the data structure definition.
 *  @warning Since the framework automatically manages the properties included in this group, adding any properties manually will be ignored.
 */
@property (nonatomic, readonly) SCPropertyGroup *defaultPropertyGroup;

/** An array of all property groups in the class definition. Property groups will be rendered to the user interface with the same order specified in this array. */
@property (nonatomic, readonly) SCPropertyGroupArray *propertyGroups;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Internal properties & methods (should only be used by the framework or when subclassing)
//////////////////////////////////////////////////////////////////////////////////////////


@property (nonatomic, readonly) NSString *ibUniqueID;
@property (nonatomic, readonly) NSString *ibName;

/**	The string name of the data structure. */
@property (nonatomic, readonly) NSString *dataStructureName;

/** Should be overridden by subclasses **/
- (instancetype)initWithibDictionary:(NSMutableDictionary *)ibDictionary;

- (void)setAllPropertiesFromibDictionary:(NSMutableDictionary *)ibDictionary;

- (void)resolveibRelationshipsUsingDictionary:(NSDictionary *)dictionary;

/** Sets up default configuration for properties such as keyPropertyName and titlePropertyName. */
- (void)setupDefaultConfiguration;

/** Returns the property data type of a property given its name. */
- (SCDataType)propertyDataTypeForPropertyWithName:(NSString *)propertyName;

/** Returns TRUE if propertyName is valid. 
 *
 *  A propertyName is valid if it exists within the defined data structure. 
 *
 *	@param propertyName The name of the property whose validity is to be checked. 
 */
- (BOOL)isValidPropertyName:(NSString *)propertyName;

/** Returns the title string value for the given object. 
 
 The title value is determined based on the value of the titlePropertyName property. 
 @note object must belong to the data structure. 
 */
- (NSString *)titleValueForObject:(NSObject *)object;

/** Returns the object with the given title in objectsArray.
 
 The title value is determined based on the value of the titlePropertyName property.
 @note All objects must belong to the data structure.
 */
- (NSObject *)objectWithTitle:(NSString *)title inObjectsArray:(NSArray *)objectsArray;

/** Returns the description string value for the given object. 
 
 The description value is determined based on the value of the descriptionPropertyName property. 
 @note object must be an instance of the data structure defined by the class. 
 */
- (NSString *)descriptionValueForObject:(NSObject *)object;

/** Generates property definitions given an array of property names. */
- (void)generatePropertiesFromPropertyNamesArray:(NSArray *)propertyNamesArray propertyTitlesArray:(NSArray *)propertyTitlesArray;

/** Generates property definitions given a string with the property names separated by semi-colons. */
- (void)generatePropertiesFromPropertyNamesString:(NSString *)propertyNamesString;

/** Automatically adds the properties that should be present in defaultPropertyGroup. */
- (void)generateDefaultPropertyGroupProperties;

/** Generates a compatible data store that can be later on used to store data instances of the definition.
 *
 *  @note Must be implemented by subclasses.
 */
- (SCDataStore *)generateCompatibleDataStore;

/** Generates a compatible data fetch options object. */
- (SCDataFetchOptions *)generateCompatibleDataFetchOptions;

@end


