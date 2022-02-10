using {mike.riskmanagement as rm} from '../db/schema';

// Annotate Risk Elements
annotate rm.Risks with {
    ID     @title : 'Risk';
    title  @title : 'Title';
    owner  @title : 'Owner';
    prio   @title : 'Priority';
    descr  @title : 'Description';
    miti   @title : 'Mitigation';
    impact @title : 'Impact';
    bp     @title : 'Business Partner'
}

// Annotate Miti Elements
annotate rm.Mitigations with {
    ID    @(
        UI.Hidden,
        Common : {Text : descr}
    );
    owner @title : 'Owner';
    descr @title : 'Description';
}

// Annotate Business Partner Elements
annotate rm.BusinessPartners with {
    BusinessPartner @title : 'Business Partner';
    LastName        @title : 'Last Name';
    FirstName       @title : 'First Name';
}

annotate rm.Risks with {
    miti @(Common : {
        // Show text, not id for mitigation on the context of risks
        Text            : miti.descr,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Mitigations',
            CollectionPath : 'Mitigations',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'descr'
                }
            ]
        }
    });
}

annotate rm.Risks with {
    bp @(Common : {ValueList : {
        Label          : 'Business Partners',
        CollectionPath : 'BusinessPartners',
        Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : bp_BusinessPartner,
                ValueListProperty : 'BusinessPartner'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'LastName'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'FirstName'
            }
        ]
    }});
}


using from './risks/annotations';
using from './common';
