import * as qs from 'qs';
import 'isomorphic-fetch';

function post(url: string, body: Object): Promise<any> {
    const opts: RequestInit = {
        method: 'POST',
        body: JSON.stringify(body),
        credentials: 'include',
        headers: {
            'Content-Type': 'application/json'
        },
    }
    return fetch(url, opts)
        .then(handleErr)
        .then(parseJson)
}

function put(url: string, body: Object): Promise<any> {
    const opts: RequestInit = {
        method: 'PUT',
        body: JSON.stringify(body),
        credentials: 'include',
        headers: {
            'Content-Type': 'application/json'
        },
    }
    return fetch(url, opts)
        .then(handleErr)
        .then(parseJson)
}

function get(url: string, body: Object = {}): Promise<any> {
    const params = qs.stringify(body)

    const opts: RequestInit = {
        method: 'GET',
        credentials: 'include',
    }
    return fetch(`${url}?${params}`, opts)
        .then(handleErr)
        .then(parseJson)
}

function _delete(url: string, body: Object = {}): Promise<any> {
    const params = qs.stringify(body);

    const opts: RequestInit = {
        method: 'DELETE',
        credentials: 'include',
    }
    return fetch(`${url}?${params}`, opts)
        .then(handleErr)
        .then(parseJson)
}

export const http = {
    post,
    put,
    get,
    delete: _delete,
}


function handleErr(res: Response): Response {
    if (!res.ok) {
        throw res;
    }
    return res;
}

function parseJson(res: Response): Promise<any> {
    if (/application\/json/.test(res.headers.get('Content-Type') || '')) {
        return res.json();
    } else {
        return res.text();
    }
}