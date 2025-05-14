using ProcessorService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
                Label : 'Customer',
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : customer.addresses.streetAddress,
                Label : 'Address',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Overview',
            ID : 'Overview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'GeneratedFacet1',
                    Label : 'General Information',
                    Target : '@UI.FieldGroup#GeneratedGroup',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Details',
                    ID : 'Details',
                    Target : '@UI.FieldGroup#Details',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Contact Info',
                    ID : 'ContactInfo',
                    Target : '@UI.FieldGroup#ContactInfo',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Conversation',
            ID : 'Conversation',
            Target : 'conversation/@UI.LineItem#Conversation',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : 'Customer',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Urgency',
            Value : urgency_code,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status_code,
            Criticality : status.criticality,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            ![@UI.Importance] : #High,
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        TypeImageUrl : 'sap-icon://alert',
    },
    UI.FieldGroup #Details : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : 'Status',
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
        ],
    },
    UI.ConnectedFields #connected : {
        $Type : 'UI.ConnectedFieldsType',
        Template : '{createdBy} {modifiedBy}',
        Data : {
            $Type : 'Core.Dictionary',
            createdBy : {
                $Type : 'UI.DataField',
                Value : createdBy,
            },
            modifiedBy : {
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },
        },
    },
    UI.ConnectedFields #connected1 : {
        $Type : 'UI.ConnectedFieldsType',
        Template : '{customer_email}HELLO{customer_phone}',
        Data : {
            $Type : 'Core.Dictionary',
            customer_email : {
                $Type : 'UI.DataField',
                Value : customer.email,
            },
            customer_phone : {
                $Type : 'UI.DataField',
                Value : customer.phone,
            },
        },
    },
    UI.FieldGroup #ContactInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataFieldForAnnotation',
                Target : 'customer/@Communication.Contact#contact1',
                Label : 'Email',
            },
        ],
    },
);

annotate service.Incidents with {
    customer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.Text : {
            $value : customer.name,
            ![@UI.TextArrangement] : #TextOnly
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Incidents with {
    status @(
        Common.Label : 'Status Code',
        Common.ValueListWithFixedValues : true,
        Common.Text : status.descr,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label : 'Urgency Code',
        Common.ValueListWithFixedValues : true,
        Common.Text : urgency.descr,
    )
};

annotate service.Urgency with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextOnly
    }
};

annotate service.Customers with @(
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : phone,
    },
    Communication.Contact #contact1 : {
        $Type : 'Communication.ContactType',
        fn : email,
        tel : [
            {
                $Type : 'Communication.PhoneNumberType',
                type : [ #work, #preferred ],
                uri : phone,
            },
        ],
    },
);

annotate service.Addresses with {
    streetAddress @(
        Common.Text : city,
        )
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Incidents.conversation with @(
    UI.LineItem #Conversation : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : 'Author',
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : 'Message',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : 'Date',
            ![@UI.Importance] : #High,
        },
    ],
    UI.SelectionPresentationVariant #Conversation : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#Conversation',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
);

annotate service.Status with @(
    UI.DataPoint #criticality : {
        Value : criticality,
        Visualization : #Progress,
        TargetValue : 100,
    }
);

annotate service.Customers with {
    name @(
        Common.Label : 'Customer',
        )
};

