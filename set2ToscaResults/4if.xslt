<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <style>
          body {background-color: #f2f2f2;}
          h1 {color: blue;}
          table {
            font-size: 16px;
            font-family: 'Trebuchet MS', Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            border-spacing: 0;
            width: 100%;
          }
          td, th {
            border: 2px solid #ddd;
            text-align: left;
			vertical-align: top;
            padding: 8px;
          }
          tr:nth-child(even){background-color: #f2f2f2}
          th {
            padding-top: 11px;
            padding-bottom: 11px;
            background-color: MediumSeaGreen;
            color: white;
          }
          .lbl {
            padding-top: 11px;
            padding-bottom: 11px;
            background-color: black;
            color: black;
            width: 200px;
          }
          .preserve-whitespace {
            white-space: pre;
          }
        </style>
      </head>
      <body>
        <h2>Execution Results</h2>
        <table>
          <thead>
            <tr>
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
          </thead>
          <tbody>
            <xsl:for-each select="/testsuites/testsuite">
              <xsl:variable name="currentSuite" select="."/>
              <xsl:for-each select="testcase">
                <tr>
                  <td>
                    <xsl:value-of select="$currentSuite/@name" />
                  </td>
                  <td>
                    <xsl:value-of select="$currentSuite/@tests" />
                  </td>
                  <td>
                    <xsl:value-of select="$currentSuite/@failures" />
                  </td>
                  <td>
                    <xsl:value-of select="$currentSuite/@skipped" />
                  </td>
                  <td>
                    <xsl:value-of select="$currentSuite/@time" />
                  </td>
                  <td>
                    <xsl:value-of select="$currentSuite/@timestamp" />
                  </td>
                  <td>
                    <xsl:value-of select="$currentSuite/@id" />
                  </td>
                  <td>
                    <xsl:value-of select="@name" />
                  </td>
                  <td>
                    <xsl:value-of select="@time" />
                  </td>
                  <td>
                    <xsl:value-of select="@timestamp" />
                  </td>
                  <td>
                    <xsl:call-template name="splitLog">
                      <xsl:with-param name="logValue" select="@log" />
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:for-each>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="splitLog">
    <xsl:param name="logValue" />
    <xsl:choose>
      <xsl:when test="contains($logValue, '+')">
        <xsl:variable name="splitValue" select="normalize-space(substring-before(concat($logValue, '+'), '+'))" />
        <xsl:choose>
          <xsl:when test="contains($splitValue, '- Failed')">
            <xsl:value-of select="normalize-space($splitValue)" />
			<div class="preserve-whitespace">
              <xsl:text>&#xA;</xsl:text>
              <xsl:text>------</xsl:text>
              <xsl:text>&#xA;</xsl:text>
            </div>
            <br/>
            <xsl:call-template name="splitLog">
              <xsl:with-param name="logValue" select="substring-after($logValue, '+')" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$splitValue" />
            <div class="preserve-whitespace">
              <xsl:text>&#xA;</xsl:text>
              <xsl:text>------</xsl:text>
              <xsl:text>&#xA;</xsl:text>
            </div>
            <xsl:call-template name="splitLog">
              <xsl:with-param name="logValue" select="substring-after($logValue, '+')" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="contains($logValue, '- Failed')">
        <xsl:value-of select="normalize-space($logValue)" />
		<div class="preserve-whitespace">
              <xsl:text>&#xA;</xsl:text>
              <xsl:text>------</xsl:text>
              <xsl:text>&#xA;</xsl:text>
            </div>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space($logValue)" />
		<div class="preserve-whitespace">
              <xsl:text>&#xA;</xsl:text>
              <xsl:text>------</xsl:text>
              <xsl:text>&#xA;</xsl:text>
            </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
