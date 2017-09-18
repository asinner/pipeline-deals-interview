import * as global from './global';

export type DealSort = 
    'deals.name'                | '-deals.name' | 
    'deals.owner_id'            | '-deal.owner_id' | 
    'deals.source_id'           | '-deals.source_id' |
    'deals.percentage'          | '-deals.percentage' | 
    'deals.expected_close_date' | '-deals.expected_close_date' | 
    'deals.created_at'          | '-deals.created_at' | 
    'deals.updated_at'          | '-deals.updated_at' | 
    'deals.closed_time'         | '-deals.closed_time';

export interface DealUser {
    full_name: string;
    id: number;
}

export type CustomFields = Object;

export type DateTimeString = string; // Example format: 2012/02/07 15:26:10 -0500

export interface DealContact {
    id: number;
    full_name: string;
}

export interface DealCollaborator {
    first_name: string;
    last_name: string;
    id: number;
    api_key: string;
}

export interface DealCompany {
    id: number;
    name: string;
}

export interface DealStage {
    id: number;
    name: string;
    percent: number;
}

export interface DealLossReason {
    id: number;
    name: string;
}

export interface DealSource {
    id: number;
    name: string;
}

export interface DealPerson {
    id: number;
    first_name: string;
    last_name: string;
}

export interface Deal {
    id: number;
    name: string;
    summary: string;
    user_id: number;
    user: DealUser;
    status: number;
    custom_fields: CustomFields;
    created_at: DateTimeString;
    updated_at: DateTimeString;
    import_id: number;
    expected_close_date_event_id: number;
    expected_close_date: global.DateString;
    closed_time: global.DateString;
    is_archived: boolean;
    value: global.Decimal;
    value_in_cents: number;
    primary_contact_id: number;
    primary_contact: DealContact;
    people: DealPerson[];
    person_ids: number[];
    collaborators: DealCollaborator[];
    shared_user_ids: number[];
    company: DealCompany;
    company_id: number;
    company_name: string;
    probability: global.Probability;
    deal_stage_id: number;
    deal_stage: DealStage;
    deal_loss_reason_id: number;
    deal_loss_reason: DealLossReason;
    deal_loss_reason_notes: string;
    source_id: number;  
    source: DealSource;
    possible_notify_user_ids: number[];
}