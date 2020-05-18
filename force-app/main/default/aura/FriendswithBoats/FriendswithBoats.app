<aura:application extends="force:slds">

    <lightning:layout class="slds-box">

        <lightning:layoutItem >

            <lightning:icon iconName="custom:custom54" alternativeText="FriendswithBoats"/>

        </lightning:layoutItem>

        <lightning:layoutItem padding="horizontal-small">

            <div class="page-section page-header">        

                <h1 class="slds-page-header__title slds-truncate slds-align-middle" title="FriendswithBoats">Friends with Boats</h1>   

            </div>

        </lightning:layoutItem>

    </lightning:layout> 

    <lightning:layout multipleRows="true">

        <lightning:layoutItem size="8" smallDeviceSize="12" mediumDeviceSize="12" largeDeviceSize="8" padding="around-small">

            <c:BoatSearch />

        </lightning:layoutItem>

        <lightning:layoutItem size="4" smallDeviceSize="12" mediumDeviceSize="12" largeDeviceSize="4" padding="around-small">

            <c:BoatDetails />

            <c:Map />

        </lightning:layoutItem>

    </lightning:layout>

    

</aura:application>