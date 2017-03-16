Silver Monkey v5 Documentation
==============================

.. note:: Documentation is still in development process. Please do not hesitate to contact us on support@silvermonkey.net for further information.

Welcome
------------

This document is meant to be a source for all information regarding the 
administration and installation of Silver Monkey v6 Views.

*Contents:*

.. toctree::
   :maxdepth: 2

   Views
   Data
   Form
   HTML-Elements
   



Views
======

Data
-----

All data which is used on the page is inserted via sql-statement. 

Example
^^^^^^^^

..code-block::
 <Query>
      			SELECT       _User.DisplayName AS Editor, 
      							  CASE ISNULL(Ticket.Workflow.value('/Workflow[1]/Open[1]/Step[1]/@Number[1]', 'varchar(50)'),'') WHEN '' THEN '' ELSE CAST(DATEDIFF(dd,GETDATE(), PreferredDate) as varchar)+ ' (' + CONVERT(varchar(20),PreferredDate,104)+')' END AS Days, 
      							  Ticket.PreferredDate, 
      					          CASE ISNULL(dbo.GetWorkflowStepName(60072, Ticket.Workflow.value('/Workflow[1]/Open[1]/Step[1]/@Number[1]', 'varchar(50)')),'') WHEN '' THEN
      									dbo.GetWorkflowStepName(60072, Ticket.Workflow.value('/Workflow[1]/Done[1]/Step[last()]/@Number[1]', 'varchar(50)'))
      							  ELSE
      									dbo.GetWorkflowStepName(60072, Ticket.Workflow.value('/Workflow[1]/Open[1]/Step[1]/@Number[1]', 'varchar(50)'))
      							  END AS Status, 
      							  Ticket.Id, 
      							  Ticket.Title, 
      							  CASE Type WHEN 1 THEN 'Feature' WHEN 2 THEN 'Error' WHEN 3 THEN 'Service Request' ELSE 'Other' END AS Type,
                                  TicketComponent.Name AS Component,
      							  CASE Ticket.Priority WHEN 0 THEN 'Kritisch' WHEN 1 THEN 'Sehr hoch' WHEN 2 THEN 'Hoch' ELSE 'Normal' END AS Prio, 
      							  Company.Name AS Customer 
      			FROM        Ticket LEFT JOIN
                                  Company ON CompanyId=Company.Id LEFT JOIN 
                                  _User ON Ticket.DeveloperId=_User.Id LEFT JOIN
                                  TicketComponent ON AffectedComponent = TicketComponent.Id
            WHERE  ('{Search}'='' OR Ticket.DisplayName LIKE '%{Search}%') AND 
                          ISNULL(Ticket.Workflow.value('/Workflow[1]/@End[1]', 'varchar(50)'),'')&lt;&gt;'True' AND
                          NOT ISNULL(Ticket.Workflow.value('/Workflow[1]/Open[1]/Step[1]/@Number[1]', 'varchar(50)'),'') = '4' AND
                          {SearchEx}
    </Query>




Form
-----

HTML-Elements
-------------


Atributes
-----------

.. csv-table::
    :header: "Atribute","Description"
    :widths: 15, 40

    "Type", "Static. If no other type is defined, textbox is going to be used as standart"
    "Data","SQL Queries used to generate data for this particular configuration"
    "ID","ID of the controlling element. If no ID is set while configuring, one will automatically be generated"
    "Title","Name of the view"
    "Format","Design options to format the views, typo, color, fontsize, etc"
    "Class",""
    "Style","css sheet for general style options"
    "Watermark","digitally watermark against copyright infringement"


Button
------

Button are triggers in order to execute certain scripts or commands with interaction from the user.
The table below shows different configuration elements.

..csv-table::
 	:header: "Atribute","Description"
    :widths: 15, 40

    "ID","Unique Name used for referencing"
    "Function", ""



..code-block::
   <Button Id="Save" Function="Save" Class="ButtonText" Image="Save16.png" AfterSaveScript="" AfterCreateScript="window.parent.RefreshList('datensatzID'); document.location.href='selfParamLink mit ID';" />

Lists
------

Display entrys of another class (e.g. table). It is possible to use placeholders for attributes in this statement.
..csv-table::
	:header: "Attribute","Description"
	:widths: 15, 40

	"ID", "Unique name, used for referencing and identifying."
	"Command",""

An example of how to use the different attributes.
..code-block::
	   <List Id="List" Command="LoadFrame('EditItem', 'View.aspx?ViewId=60104&amp;Id='+strId, strDirection);" Add="LoadFrame('EditItem', 'View.aspx?ViewId=60104&amp;Id=-2', 'down');">
          <ListItem>
            <div class="Content">
              <div class="Title">{DisplayName}</div>
              <div class="Text">-</div>
            </div>
          </ListItem>
        </List>

WorkflowControl
----------------

ButtonMore
-----------
Is used to initiate furher actions for this button. For example postPushButton scripts as seem in the example below.

..code-block::
 <ButtonMore>
            <MenuItem Icon="" Function="Delete" AfterDeleteScript="window.parent.RefreshList(); $('form').html('');">
              <Title Lang="DE">Löschen</Title>
            </MenuItem>
            <OpenInNewWindow />
          </ButtonMore>

WorkflowChart
-------------
Visualizes workflows through bpmn or epk diagramm.

Insert jpeg here of visualized workflow.

Explanation how it works to implement one of these workflows

Chart
------
A visualization of numbers in a diagram. Used mostly in dashboards to show peaks of downloads or orders in this tool.

insert jpeg here

insert how it works below

Data comes from an sql?

Search
-------
A function to iterate through the whole database comparing the search item with it.
Can be implemented through a search bar or used in the configuration as seen below.

..code-block::
<Div Class="RepeaterSearch">
        <Search Id="Products" Script="ProductsRefresh();" />
      </Div>
Rating
---------
An attribute used for items such as hardware or softwware rated by the users who ordered them in self service. Based on this rating filtering and sorting items in different views. The shop area for self service is an example for.
every item has an additional field for a rating from 0-5.

Insert shop picture unsorted and sorted.

Tile
----------



NavTree
----------
Navigationelement used to 
..code-block::
 <NavTree Table="ShopCategory" OrderBy="SortOrder" Filter="" SelectedId="{?CategoryId}" Script="document.location.href='View.aspx?ViewId=20030&amp;NoHeaderAnimation=1&amp;CategoryId={Id}';" />

Repeater
--------
A funcion to repeat certain commands. Refreshing a list in a certain view for example.

..code-block::

<Repeater Id="Products" Source="Products" PageSize="16">
          <div class="ShopProduct" Style="cursor:default; color:#404040;">
            <div class="ShopProductImage" Style="opacity:1;">
              <img src="{EnsureFile:.\Cache\Table\{GUID}_Image1.png;Image1;./Resource/Images/MissingProductImage.png}" />
            </div>
            <div class="ShopProductTitle">
              <div class="Title">{DisplayName}</div>
              <Span>{ItemName}</Span>
            </div>
          </div>
        </Repeater>

DataTable
----------
Represents one table of in-memory data.



List
--------


..code-block::
<list type="bullet" | "number" | "table">  
    <listheader>  
        <term>term</term>  
        <description>description</description>  
    </listheader>  
    <item>  
        <term>term</term>  
        <description>description</description>  
    </item>  
</list>  

Splitter
----------



..code-block::
<Splitter>
      <Left>
        <List Id="List" Command="LoadFrame('EditItem', 'View.aspx?ViewId=60104&amp;Id='+strId, strDirection);" Add="LoadFrame('EditItem', 'View.aspx?ViewId=60104&amp;Id=-2', 'down');">
          <ListItem>
            <div class="Content">
              <div class="Title">{DisplayName}</div>
              <div class="Text">-</div>
            </div>
          </ListItem>
        </List>
      </Left>
      <Right>
        <Frame Id="EditItem" />
      </Right>
    </Splitter>

Functionbar
----------------

Frame
------
Used to frame a certain item to differentiate from the other elements while hovering with the mouse over it.

..code-block::
 <Frame Id="EditItem" />


Header
-------
Menubar to navigate trough a certain page/view. It is built up like a navigation-element.

..code-block::
<Header>
      <HeaderMenuItem Title="Geräte" Link="View.aspx?ViewId=40046" />
      <HeaderMenuItem Title="Software" Link="View.aspx?ViewId=40049" />
      <HeaderMenuItem Title="Mitarbeiter" Link="View.aspx?ViewId=40053" />
      <HeaderMenuMore Title="Weitere">
        <HeaderMenuItem Title="Abteilungen" Link="View.aspx?ViewId=40057" />
        <HeaderMenuItem Title="Firmen" Link="View.aspx?ViewId=60103" />
        <HeaderMenuItem Title="Standorte" Link="View.aspx?ViewId=60097" />
        <HeaderMenuItem Title="Berechtigungen" Link="View.aspx?ViewId=60113" />
      </HeaderMenuMore>
    </Header>

Script
-------

Style
------

General configuration
------------------------

How to generally configurate your own views is descriped here. The items are linked to the configuration items in order to give further explanation.
..Link every item to its own site

..code-block::
<View Icon="**Place designated icon here**">
  <Name Lang="DE">**Name of the view used for referencing**</Name>
  <Data>
    **SQL-Query to get the needed data**
  </Data>
  <Form>
  **specify form of the view here**
    <Header>
      <HeaderMenuItem Title="**First Level menu item**" Link="**Link to the specified view**" />
      <HeaderMenuMore Title="**First Level menu item**">
        <HeaderMenuItem Title="**Second level menu item**" Link="**Link to the specified view**" />
      </HeaderMenuMore>
    </Header>
    <Splitter>
      <Left>
        <List Id="List" Command="LoadFrame('EditItem', 'View.aspx?ViewId=40050&amp;Id='+strId, strDirection);" Add="LoadFrame('EditItem', 'View.aspx?ViewId=40050&amp;Id=-2', 'down');">
          <ListItem>
            <div class="Content">
              <div class="Title">{DisplayName}</div>
              <div class="Text">{Count} Installationen</div>
            </div>
          </ListItem>
        </List>
      </Left>
      <Right>
        <Frame Id="EditItem" />
      </Right>
    </Splitter>
  </Form>
</View>
