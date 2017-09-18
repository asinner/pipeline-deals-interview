import { http } from '../../http';
import { Resource } from './resource';
import * as data from '../data/index';

interface DealGetAllRequest {
    page?: number;
    per_page?: number;
    search_id?: number;
    totals?: boolean;
    conditions?: {
        deal_id?: number | string; // You can specify multiple deals with CSV value
        deal_name?: string;
        deal_percentage?: number;
        deal_source?: number;
        deal_owner?: number;
        deal_value?: number;
        deal_stage?: number;
        exp_close?: data.DateTimeRange;
        deal_created?: data.DateTimeRange;
        deal_modified?: data.DateTimeRange;
        deal_closed_time?: data.DateTimeRange;
        person_full_name?: string;
        person_email?: string;
        person_phone?: string;
        person_city?: string;
        person_state?: string;
        person_work_zip?: string;
        person_zip?: string;
        person_company_phone?: string;
        sort?: data.DealSort; 
    }
}

interface DealGetAllResponse { 
    deals: data.Deal[]
}

export class DealResource extends Resource {
    static list(req: DealGetAllRequest): Promise<DealGetAllResponse> {
        return http.get('/api/deals', req);
    }
}