#include <fstream>
#include <vector>
#include <set>
#include <algorithm>

using namespace std;

struct endp {
    int d_latency;
    vector< pair<int, int> > c_latency;
};

struct req {
    int r_vid;
    int r_ep;
    int r_nr;
};

struct c_v_inf {
    int id_vid, nr_req;
    long long ponder;
};

struct cac {
    int cac_size, nr_vid;
    vector<c_v_inf> cac_videos;
};

vector<int> video;
vector<endp> endpoint;
vector<req> request;
vector<cac> caches;
set<int> removed;
int v, e, r, c, x;

bool compare(pair<int, int> i, pair<int, int> j) {
    return (i.second < j.second);
}

void read(){
    ifstream in("videos_worth_spreading.in");
    in >> v >> e >> r >> c >> x;
    video.resize(v, 0);
    caches.resize(c);

    int i;

    for (i = 0; i < v; ++i) {
        int v_size;
        in >> v_size;
        if (v_size > x) {
            removed.insert(i);
        } else {
            video[i] = v_size;
        }
    }

    for (i = 0; i < e; ++i) {
        int k;
        endp ep;
        in >> ep.d_latency >> k;
        int j;
        for (j = 0; j < k; ++j) {
            int cache_id, cache_lat;
            in >> cache_id >> cache_lat;
            ep.c_latency.push_back(make_pair(cache_id, cache_lat));
        }
        endpoint.push_back(ep);
    }

    for (i = 0; i < e; ++i) {
        sort(endpoint[i].c_latency.begin(),
             endpoint[i].c_latency.end(),
             compare);
    }

    for (i = 0; i < r; ++i) {
        req rq;
        in >> rq.r_vid >> rq.r_ep >> rq.r_nr;
        if (removed.find(rq.r_vid) == removed.end()) {
            request.push_back(rq);
        }
    }
    in.close();

    for (i = 0; i < c; ++i) {
        caches[i].cac_size = x;
        caches[i].cac_videos.resize(10000);
    }
}

void complete_cache() {
    for (int i = 0; i < r; ++i) {
        int r_ep = request[i].r_ep;
        int r_vid = request[i].r_vid;
        int r_nr = request[i].r_nr;
        for (int j = 0; j < endpoint[r_ep].c_latency.size(); ++j) {
            int c_lat = endpoint[r_ep].c_latency[j].second;
            int poz = endpoint[r_ep].c_latency[j].first;
            caches[poz].cac_videos[r_vid].ponder += (endpoint[r_ep].d_latency - c_lat) * r_nr * 1LL;
            caches[poz].cac_videos[r_vid].id_vid = r_vid;
            caches[poz].cac_videos[r_vid].nr_req += r_nr;
        }
    }
}

bool compare_caches(c_v_inf i, c_v_inf j) {
    if (i.nr_req < j.nr_req)
        return false;
    else if (i.nr_req > j.nr_req)
        return true;
    else {
        return (i.ponder > j.ponder);
    }
}

void sort_caches() {
    for (int i = 0; i < c; ++i) {
        sort(caches[i].cac_videos.begin(),
             caches[i].cac_videos.end(),
             compare_caches);
    }
}

void final_caches() {
    for (int i = 0; i < c; ++i) {
        for (int j = 0; j < caches[i].cac_videos.size(); ++j)
        if (caches[i].cac_videos[j].nr_req != 0) {
            if (video[caches[i].cac_videos[j].id_vid] <= caches[i].cac_size) {
                caches[i].cac_size -= video[caches[i].cac_videos[j].id_vid];

            } else {
                caches[i].cac_videos[j].nr_req = 0;
            }
        }
    }
}

int main() {
    ofstream out("videos_worth_spreading.out");
    read();
    complete_cache();
    sort_caches();
    final_caches();
    int nr_caches = 0;
    for (int i = 0; i < c; ++i) {
        caches[i].nr_vid = 0;
        for (int j = 0; j < caches[i].cac_videos.size(); ++j)
            if (caches[i].cac_videos[j].nr_req != 0) {
                ++caches[i].nr_vid;
            }
        if (caches[i].nr_vid != 0)
            ++nr_caches;
    }
    out << nr_caches << '\n';
    for (int i = 0; i < c; ++i) {
        if (caches[i].nr_vid != 0) {
            out << i << ' ';
        for (int j = 0; j < caches[i].cac_videos.size(); ++j)
            if (caches[i].cac_videos[j].nr_req != 0) {
                out << caches[i].cac_videos[j].id_vid << ' ';
            }
        out << '\n';
        }
    }
    return 0;
}
