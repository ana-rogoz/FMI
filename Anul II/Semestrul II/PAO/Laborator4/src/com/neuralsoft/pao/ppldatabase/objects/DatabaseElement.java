package com.neuralsoft.pao.ppldatabase.objects;

import java.io.Serializable;

public abstract class DatabaseElement implements Serializable
{

    /**
     * This will be used to show nicely the name of the type.<br />
     * Will appear in the object list and combo box;<br />
     * @return A string with the nice name (example: Student, Professor);
     */
    public abstract String getElementType();

    /**
     * This will allow us to manipulate which columns we show in the list table.<br />
     * Basically defines the table header.
     * @return An array with the column names.
     */
    public final String[] getListedFields()
    {
        return new String[] { "Name", "Type" };
    }

    /**
     * This will fetch a list of values for the columns. 
     * @return An array with the values.
     */
    public final String[] getDisplayedValues()
    {
        return new String[] { getName(), getType() };
    }

    /**
     * This will tell the framework which fields the object has so it can prepare the GUI
     * @return The array of fields.
     */
    public abstract String[] getDataFieldNames();

    /**
     * Used to set the field indicated by getDatafieldNames()[position] with the value
     * @param position The position.
     * @param value The value.
     */
    public abstract void setFieldAt(int position, String value);

    /**
     * Should return what "Name" means for this object.
     * @return
     */
    public abstract String getName();

    /**
     * Should return what "Type" means for this object. <br />
     * Example: Teacher(Math) or Student (year 1). etc
     * @return
     */
    public abstract String getType();

}