<%@ include file="/init.jsp" %>

<%
int USA_COUNTRY_ID = 19;
%>

<portlet:actionURL name="<%=MVCCommandNames.SUBMIT %>" var="createUserAccountURL" />
<aui:form action="<%= createUserAccountURL %>" method="post" name="fm" >
	<liferay-ui:error exception="<%= UserEmailAddressException.MustNotBeDuplicate.class %>" message="the-email-address-you-requested-is-already-taken" />
	<liferay-ui:error exception="<%= UserScreenNameException.MustNotBeDuplicate.class %>" message="the-screen-name-you-requested-is-already-taken" />
    <liferay-ui:error exception="<%= AMFRegistrationException.class %>">
    <%
        AMFRegistrationException rve = (AMFRegistrationException)errorException;
    %>
            <liferay-ui:message key="<%= rve.getMessage() %>" />
    </liferay-ui:error>
    <liferay-ui:error exception="<%= UserExtraInfoException.class %>">
    <%
        UserExtraInfoException rve = (UserExtraInfoException)errorException;
    %>
            <liferay-ui:message key="<%= rve.getMessage() %>" />
    </liferay-ui:error>
    <div class="form-group">
        <h3 class="sheet-subtitle">Basic Info</h3>
        <div class="row">
            <div class="col-md-5">
                <aui:input name="username" label="Username" autocomplete="off">
                    <aui:validator name="required" />
                    <aui:validator name="maxLength">16</aui:validator>
                    <aui:validator name="minLength">4</aui:validator>
                    <aui:validator name="alphanum" />
                </aui:input>
                <aui:input name="email_address" label="Email Address" autocomplete="off">
                   <aui:validator name="email" />
                   <aui:validator name="maxLength">255</aui:validator>
                   <aui:validator name="required" />
                </aui:input>
                <aui:input name="first_name" label="First Name">
                    <aui:validator name="maxLength">50</aui:validator>
                    <aui:validator name="required"/>
                    <aui:validator name="alphanum" />
                </aui:input>
                <aui:input name="last_name" label="Last Name">
                    <aui:validator name="maxLength">50</aui:validator>
                    <aui:validator name="required"/>
                    <aui:validator name="alphanum" />
                </aui:input>
            </div>
            <div class="col-md-5">
                <aui:input name="password1" label="Password" type="password">
                    <aui:validator name="required" />
                    <aui:validator errorMessage="invalid-password-policy" name="custom">
                        function(val, fieldNode, ruleValue) {
                            var regex = new RegExp(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{6,}$/);
                            return regex.test(val);
                        }
                    </aui:validator>
                </aui:input>
                <aui:input name="password2" label="Confirm Password" type="password">
                    <aui:validator name="required" />
                    <aui:validator name="equalTo" errorMessage="Password not match">'#<portlet:namespace />password1'</aui:validator>
                </aui:input>
                <aui:input name="birthday" label="Birthday" model="<%= Contact.class %>"/>
                <aui:input name="male" type="checkbox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <h3 class="sheet-subtitle">Phone</h3>
        <div class="row">
            <div class="col-md-5">
                <aui:input name="home_phone" label="Home Phone">
                    <aui:validator name="digits" />
                    <aui:validator name="maxLength">10</aui:validator>
                    <aui:validator name="minLength">10</aui:validator>
                </aui:input>
            </div>
            <div class="col-md-5">
                <aui:input name="mobile_phone" label="Mobile Phone">
                    <aui:validator name="digits" />
                    <aui:validator name="maxLength">10</aui:validator>
                    <aui:validator name="minLength">10</aui:validator>
                </aui:input>
            </div>
        </div>
    </div>
    <div class="form-group">
        <h3 class="sheet-subtitle">Billing Address (US-Only)</h3>
        <div class="row">
            <div class="col-md-5">
                <aui:input name="address" label="Address 1">
                    <aui:validator name="required" />
                    <aui:validator name="maxLength">255</aui:validator>
                </aui:input>
                <aui:input name="address2" label="Address 2">
                    <aui:validator name="maxLength">255</aui:validator>
                </aui:input>
                <aui:input name="city" label="City">
                    <aui:validator name="maxLength">255</aui:validator>
                    <aui:validator name="required" />
                </aui:input>
				<aui:select label="State" name="state">
                    <aui:validator name="required" />
				</aui:select>
                <aui:input name="zip" label="Zip Code">
                    <aui:validator name="required" />
                    <aui:validator name="maxLength">5</aui:validator>
                </aui:input>
            </div>
            <div class="col-md-5">
            </div>
        </div>
    </div>
    <div class="form-group">
        <h3 class="sheet-subtitle">Misc.</h3>
        <div class="row">
            <div class="col-md-5">
                <aui:select label="Security Question" name="security_question">
                	<%
                	Set<String> questions = new HashSet<>();
                	questions.add("what-is-your-mother-maiden-name");
                	questions.add("what-is-make-of-your-first-car");
                	questions.add("what-is-your-high-school-mascot");
                	questions.add("who-is-your-favorite-actor");
                	for (String question : questions) {
                	%>
                        <aui:option label="<%= question %>" />
                	<%
                	}
                	%>
                </aui:select>
                <aui:input name="security_answer" label="Answer">
                    <aui:validator name="required" />
                </aui:input>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <aui:input name="accepted_tou" type="checkbox"
            label="terms-of-use">
                <aui:validator name="required" />
            </aui:input>
        </div>
    </div>
    <aui:button-row>
        <aui:button type="submit" value="Create"/>
    </aui:button-row>

    <aui:script use="liferay-dynamic-select">
    		new Liferay.DynamicSelect([
    			{
    				selectData: Liferay.Address.getCountries,
    				selectDesc: 'nameCurrentValue',
    				selectSort: true,
    				selectId: 'countryId',
    				selectVal: '<%= USA_COUNTRY_ID %>'
    			},
    			{
    				select: '<portlet:namespace />state',
    				selectData: Liferay.Address.getRegions,
    				selectDesc: 'name',
    				selectSort: true,
    				selectId: 'regionId',
    			}
    		]);
        </aui:script>


</aui:form>