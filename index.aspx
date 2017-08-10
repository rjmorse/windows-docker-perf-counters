<%@ Language=C# %>
<HTML>
   <script runat="server" language="C#">
   void MyButton_OnClick(Object sender, EventArgs e)
   {
      MyLabel.Text = MyTextbox.Text.ToString();
   }
   </script>
   <body>
      <form id="MyForm" runat="server">
         <h1>Submit textbox to echo back</h1>
         <asp:textbox id="MyTextbox" text="Hello World" runat="server"></asp:textbox>
         <asp:button id="MyButton" text="Echo Input" OnClick="MyButton_OnClick" runat="server"></asp:button>
         <asp:label id="MyLabel" runat="server"></asp:label>
      </form>
   </body>
</HTML>