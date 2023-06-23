<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <body>
        <h2>Execution Results</h2>
        <table border="1">
          <tr bgcolor="#9acd32">
            <th>testsuite_name</th>
            <th>testsuite_tests</th>
            <th>testsuite_failures</th>
            <th>testsuite_skipped</th>
            <th>testsuite_time</th>
            <th>testsuite_timestamp</th>
            <th>testsuite_id</th>
            <th>testcase_name</th>
            <th>testcase_time</th>
            <th>testcase_timestamp</th>
            <th>testcase_log</th>
          </tr>
          <xsl:for-each select="/testsuites/testsuite/testcase">
            <tr>
              <td>
                <xsl:value-of select="/testsuites/testsuite/@name"/>
              </td>
              <td>
                <xsl:value-of select="/testsuites/testsuite/@tests"/>
              </td>
              <td>
                <xsl:value-of select="/testsuites/testsuite/@failures"/>
              </td>
              <td>
                <xsl:value-of select="/testsuites/testsuite/@skipped"/>
              </td>
              <td>
                <xsl:value-of select="/testsuites/testsuite/@time"/>
              </td>
              <td>
                <xsl:value-of select="/testsuites/testsuite/@timestamp"/>
              </td>
              <td>
                <xsl:value-of select="/testsuites/testsuite/@id"/>
              </td>
              <td>
                <xsl:value-of select="@name"/>
              </td>
              <td>
                <xsl:value-of select="@time"/>
              </td>
              <td>
                <xsl:value-of select="@timestamp"/>
              </td>
              <td>
                <xsl:call-template name="splitLog">
                  <xsl:with-param name="logValue" select="@log"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template name="splitLog">
  <xsl:param name="logValue"/>
  <xsl:choose>
    <xsl:when test="contains($logValue, '+')">
	<xsl:with-param name="logValue" select="@log"/>
      <xsl:value-of select="normalize-space(substring-before(concat($logValue, '+'), '+'))"/>
	  <style>
          .preserve-whitespace {
            white-space: pre;
          }
        </style>
	   <xsl class="preserve-whitespace">
              <xsl:text>&#xA;</xsl:text>
			  <xsl:text>------</xsl:text>
			  <xsl:text>&#xA;</xsl:text>
            </xsl>
      <xsl:call-template name="splitLog">
        <xsl:with-param name="logValue" select="substring-after($logValue, '+')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="normalize-space($logValue)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>