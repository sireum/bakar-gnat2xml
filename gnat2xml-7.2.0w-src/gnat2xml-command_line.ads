------------------------------------------------------------------------------
--                                                                          --
--                            GNAT2XML COMPONENTS                           --
--                                                                          --
--                 G N A T 2 X M L . C O M M A N D _ L I N E                --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                    Copyright (C) 2012, AdaCore, Inc.                     --
--                                                                          --
-- Gnat2xml is free software; you can redistribute it and/or modify it      --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software Foundation;  either version 2,  or  (at your option)  any later --
-- version. Gnat2xml is distributed  in the hope  that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of MER-      --
-- CHANTABILITY or  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General  --
-- Public License for more details. You should have received a copy of the  --
-- GNU General Public License distributed with GNAT; see file COPYING. If   --
-- not, write to the Free Software Foundation, 59 Temple Place Suite 330,   --
-- Boston, MA 02111-1307, USA.                                              --
-- The gnat2xml tool was derived from the Avatox sources.                   --
------------------------------------------------------------------------------

--  Command Line Arguments.

with Ada.Containers.Indefinite_Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Gnat2xml.Environment;

package Gnat2xml.Command_Line is

   --  Call Process_Gnat2xml_Command_Line first (exactly once). Then call
   --  Gnat2xml_Options as many times as you like to get the argument values.

   procedure Process_Gnat2xml_Command_Line;
   --  Raises Command_Line_Error on error, after printing error messages.

   Command_Line_Error : exception;

   package String_Vectors is
      new Ada.Containers.Indefinite_Vectors (Positive, String);
   use String_Vectors;
   subtype String_Vector is String_Vectors.Vector;

   use Environment.File_Name_Handling;

   type Gnat2xml_Options_Type is limited
      record
         Help, Version : Boolean := False;

         Input_Files : Environment.File_Name_Entries;
         Include_Directories : Environment.File_Name_Entries;

         Output_Dir : Unbounded_String;
         --  Empty means send to standard output

         Compact_XML  : Boolean := False;
         --  True if the -q switch was given, which means we should generate
         --  less verbose XML. In particular, we should generate XML according
         --  to the ada-schema.compact.xsd schema, rather than the
         --  ada-schema.xsd one.

         Debug_Mode   : Boolean := False;
         Verbose_Mode : Boolean := False;
         Delete_Trees : Boolean := True;
      end record;

   function Gnat2xml_Options return access constant Gnat2xml_Options_Type;

   procedure Gnat2xml_Usage;
   --  Prints a usage message

   procedure Print_Command_Line;
   --  Prints the command line to standard output

end Gnat2xml.Command_Line;