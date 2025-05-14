sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/incidentmanagement/test/integration/FirstJourney',
		'ns/incidentmanagement/test/integration/pages/IncidentsList',
		'ns/incidentmanagement/test/integration/pages/IncidentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, IncidentsList, IncidentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/incidentmanagement') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheIncidentsList: IncidentsList,
					onTheIncidentsObjectPage: IncidentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);