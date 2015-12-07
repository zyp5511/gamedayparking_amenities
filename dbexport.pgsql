--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO test;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO test;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE account_emailaddress_id_seq OWNED BY account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO test;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO test;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE account_emailconfirmation_id_seq OWNED BY account_emailconfirmation.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO test;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO test;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO test;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO test;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO test;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO test;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO test;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO test;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO test;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO test;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO test;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO test;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO test;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO test;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO test;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO test;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO test;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO test;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO test;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO test;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO test;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: message_message; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE message_message (
    id integer NOT NULL,
    subject character varying(80) NOT NULL,
    message character varying(1000) NOT NULL,
    read boolean NOT NULL,
    date date,
    is_reservation boolean NOT NULL,
    receiver_id integer NOT NULL,
    sender_id integer NOT NULL
);


ALTER TABLE public.message_message OWNER TO test;

--
-- Name: message_message_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE message_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_message_id_seq OWNER TO test;

--
-- Name: message_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE message_message_id_seq OWNED BY message_message.id;


--
-- Name: message_resmessage; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE message_resmessage (
    id integer NOT NULL,
    res_date timestamp with time zone,
    is_approved boolean NOT NULL,
    has_responded boolean NOT NULL,
    transaction_id character varying(255),
    num_spots integer NOT NULL,
    message_id integer NOT NULL,
    parkingspot_id integer NOT NULL,
    reviewed_id integer
);


ALTER TABLE public.message_resmessage OWNER TO test;

--
-- Name: message_resmessage_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE message_resmessage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_resmessage_id_seq OWNER TO test;

--
-- Name: message_resmessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE message_resmessage_id_seq OWNED BY message_resmessage.id;


--
-- Name: parkingspot_parkingspot; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE parkingspot_parkingspot (
    id integer NOT NULL,
    street_address character varying(70) NOT NULL,
    city character varying(30) NOT NULL,
    state character varying(2) NOT NULL,
    zipcode integer,
    location geometry(Point,4326),
    description character varying(256) NOT NULL,
    amenities text NOT NULL,
    cost integer,
    photos character varying(100) NOT NULL,
    default_num_spots integer NOT NULL,
    parking_spot_avail text NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE public.parkingspot_parkingspot OWNER TO test;

--
-- Name: parkingspot_parkingspot_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE parkingspot_parkingspot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parkingspot_parkingspot_id_seq OWNER TO test;

--
-- Name: parkingspot_parkingspot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE parkingspot_parkingspot_id_seq OWNED BY parkingspot_parkingspot.id;


--
-- Name: review_review; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE review_review (
    id integer NOT NULL,
    headline character varying(60) NOT NULL,
    review_text character varying(4000) NOT NULL,
    rating integer NOT NULL,
    parkingspot_id integer NOT NULL,
    reviewer_id integer NOT NULL
);


ALTER TABLE public.review_review OWNER TO test;

--
-- Name: review_review_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE review_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.review_review_id_seq OWNER TO test;

--
-- Name: review_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE review_review_id_seq OWNED BY review_review.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(255) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO test;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialaccount_id_seq OWNER TO test;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE socialaccount_socialaccount_id_seq OWNED BY socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(100) NOT NULL,
    secret character varying(100) NOT NULL,
    key character varying(100) NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO test;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_id_seq OWNER TO test;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE socialaccount_socialapp_id_seq OWNED BY socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE socialaccount_socialapp_sites (
    id integer NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO test;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_sites_id_seq OWNER TO test;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE socialaccount_socialapp_sites_id_seq OWNED BY socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO test;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialtoken_id_seq OWNER TO test;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE socialaccount_socialtoken_id_seq OWNED BY socialaccount_socialtoken.id;


--
-- Name: userprof_adminuser; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE userprof_adminuser (
    registered boolean NOT NULL,
    extended_user_id integer NOT NULL
);


ALTER TABLE public.userprof_adminuser OWNER TO test;

--
-- Name: userprof_extendeduser; Type: TABLE; Schema: public; Owner: test; Tablespace: 
--

CREATE TABLE userprof_extendeduser (
    main_user_id integer NOT NULL,
    stripe_id character varying(255)
);


ALTER TABLE public.userprof_extendeduser OWNER TO test;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY account_emailaddress ALTER COLUMN id SET DEFAULT nextval('account_emailaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('account_emailconfirmation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY message_message ALTER COLUMN id SET DEFAULT nextval('message_message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY message_resmessage ALTER COLUMN id SET DEFAULT nextval('message_resmessage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY parkingspot_parkingspot ALTER COLUMN id SET DEFAULT nextval('parkingspot_parkingspot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY review_review ALTER COLUMN id SET DEFAULT nextval('review_review_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialtoken_id_seq'::regclass);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: test
--

COPY account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
1	mprouve@optonline.net	f	t	2
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('account_emailaddress_id_seq', 1, true);


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: test
--

COPY account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
1	2015-12-07 14:56:20.159203-06	2015-12-07 14:56:20.168551-06	cknllkkchqm76cjto3v4swqa6slqlheuxdrvt98clewwwrbksmuncrmyfbwqbr9i	1
\.


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('account_emailconfirmation_id_seq', 1, true);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: test
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: test
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add site	7	add_site
20	Can change site	7	change_site
21	Can delete site	7	delete_site
22	Can add email address	8	add_emailaddress
23	Can change email address	8	change_emailaddress
24	Can delete email address	8	delete_emailaddress
25	Can add email confirmation	9	add_emailconfirmation
26	Can change email confirmation	9	change_emailconfirmation
27	Can delete email confirmation	9	delete_emailconfirmation
28	Can add extended user	10	add_extendeduser
29	Can change extended user	10	change_extendeduser
30	Can delete extended user	10	delete_extendeduser
31	Can add admin user	11	add_adminuser
32	Can change admin user	11	change_adminuser
33	Can delete admin user	11	delete_adminuser
34	Can add parking spot	12	add_parkingspot
35	Can change parking spot	12	change_parkingspot
36	Can delete parking spot	12	delete_parkingspot
37	Can add review	13	add_review
38	Can change review	13	change_review
39	Can delete review	13	delete_review
40	Can add message	14	add_message
41	Can change message	14	change_message
42	Can delete message	14	delete_message
43	Can add res message	15	add_resmessage
44	Can change res message	15	change_resmessage
45	Can delete res message	15	delete_resmessage
46	Can add social application	16	add_socialapp
47	Can change social application	16	change_socialapp
48	Can delete social application	16	delete_socialapp
49	Can add social account	17	add_socialaccount
50	Can change social account	17	change_socialaccount
51	Can delete social account	17	delete_socialaccount
52	Can add social application token	18	add_socialtoken
53	Can change social application token	18	change_socialtoken
54	Can delete social application token	18	delete_socialtoken
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('auth_permission_id_seq', 54, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: test
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	!ZiKS97zPo2vsXoZu1wrmoGga2zVFsK2UQMDtE9zq	2015-12-07 14:56:20.181156-06	f	marco	Marco	Prouve	mprouve@optonline.net	f	t	2015-12-07 14:56:20.116563-06
1	pbkdf2_sha256$20000$WBgvgUXmTSDL$pi2fAfy/Xj98jCbLENQlfAntPduXlje7F0ZVR4P4yy0=	2015-12-07 15:04:01.72941-06	t	mprouve			marcoprouve@gmail.com	t	t	2015-12-06 20:39:03.887286-06
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: test
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: test
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2015-12-06 20:40:32.562102-06	1	Gameday App	1		16	1
2	2015-12-06 20:42:10.162323-06	1	mprouve	1		10	1
3	2015-12-06 20:42:26.743698-06	1	mprouve	1		11	1
4	2015-12-06 21:30:54.554646-06	7	621 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
5	2015-12-06 21:32:17.710953-06	6	633 N Henry Street	2	Changed amenities and parking_spot_avail.	12	1
6	2015-12-06 21:32:31.399196-06	5	222 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
7	2015-12-06 21:32:40.15989-06	4	437 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
8	2015-12-06 21:33:14.157821-06	3	221 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
9	2015-12-06 21:33:22.508656-06	2	614 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
10	2015-12-06 21:33:31.618738-06	1	420 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
11	2015-12-06 21:41:02.912948-06	7	621 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
12	2015-12-06 21:41:55.343235-06	7	621 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
13	2015-12-06 21:42:16.505783-06	6	633 N Henry Street	2	Changed amenities and parking_spot_avail.	12	1
14	2015-12-06 21:43:09.65733-06	7	621 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
15	2015-12-06 21:43:15.339014-06	6	633 N Henry Street	2	Changed amenities and parking_spot_avail.	12	1
16	2015-12-06 21:44:05.31624-06	7	621 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
17	2015-12-06 21:44:11.605372-06	6	633 N Henry Street	2	Changed amenities and parking_spot_avail.	12	1
18	2015-12-06 21:44:19.887337-06	5	222 Langdon St.	2	Changed amenities, default_num_spots and parking_spot_avail.	12	1
19	2015-12-06 21:44:26.515979-06	7	621 N. Frances St.	2	Changed amenities, default_num_spots and parking_spot_avail.	12	1
20	2015-12-06 21:44:38.730978-06	4	437 N. Frances St.	2	Changed amenities, default_num_spots and parking_spot_avail.	12	1
21	2015-12-06 21:44:46.757259-06	3	221 Langdon St.	2	Changed amenities, default_num_spots and parking_spot_avail.	12	1
22	2015-12-06 21:44:51.751576-06	3	221 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
23	2015-12-06 21:44:59.33804-06	2	614 Langdon St.	2	Changed amenities, default_num_spots and parking_spot_avail.	12	1
24	2015-12-06 21:45:07.493749-06	1	420 Langdon St.	2	Changed amenities, default_num_spots and parking_spot_avail.	12	1
25	2015-12-06 22:02:42.450421-06	6	633 N Henry Street	2	Changed state, amenities and parking_spot_avail.	12	1
26	2015-12-06 23:04:42.618228-06	8	613 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
27	2015-12-06 23:04:50.279611-06	7	621 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
28	2015-12-06 23:04:57.970488-06	6	633 N Henry Street	2	Changed amenities and parking_spot_avail.	12	1
29	2015-12-06 23:05:12.178551-06	5	222 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
30	2015-12-06 23:05:26.406613-06	4	437 N. Frances St.	2	Changed amenities and parking_spot_avail.	12	1
31	2015-12-06 23:05:35.561574-06	3	221 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
32	2015-12-06 23:05:42.758905-06	2	614 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
33	2015-12-06 23:05:53.316252-06	1	420 Langdon St.	2	Changed amenities and parking_spot_avail.	12	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 33, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: test
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	sites	site
8	account	emailaddress
9	account	emailconfirmation
10	userprof	extendeduser
11	userprof	adminuser
12	parkingspot	parkingspot
13	review	review
14	message	message
15	message	resmessage
16	socialaccount	socialapp
17	socialaccount	socialaccount
18	socialaccount	socialtoken
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('django_content_type_id_seq', 18, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: test
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2015-12-06 20:37:33.919745-06
2	contenttypes	0002_remove_content_type_name	2015-12-06 20:37:33.970053-06
3	auth	0001_initial	2015-12-06 20:37:34.210284-06
4	auth	0002_alter_permission_name_max_length	2015-12-06 20:37:34.232119-06
5	auth	0003_alter_user_email_max_length	2015-12-06 20:37:34.256437-06
6	auth	0004_alter_user_username_opts	2015-12-06 20:37:34.273945-06
7	auth	0005_alter_user_last_login_null	2015-12-06 20:37:34.293145-06
8	auth	0006_require_contenttypes_0002	2015-12-06 20:37:34.296479-06
9	userprof	0001_initial	2015-12-06 20:37:34.351881-06
10	parkingspot	0001_initial	2015-12-06 20:37:34.395923-06
11	parkingspot	0002_parkingspot_owner	2015-12-06 20:37:34.429648-06
12	review	0001_initial	2015-12-06 20:37:36.669438-06
13	message	0001_initial	2015-12-06 20:37:36.762207-06
14	message	0002_auto_20151207_0237	2015-12-06 20:37:36.858974-06
15	account	0001_initial	2015-12-06 20:37:38.927963-06
16	account	0002_email_max_length	2015-12-06 20:37:38.947573-06
17	admin	0001_initial	2015-12-06 20:37:38.997025-06
18	sessions	0001_initial	2015-12-06 20:37:39.027186-06
19	sites	0001_initial	2015-12-06 20:37:39.044588-06
20	socialaccount	0001_initial	2015-12-06 20:37:39.283837-06
21	review	0002_auto_20151207_0351	2015-12-06 21:51:17.536707-06
22	message	0003_auto_20151207_0711	2015-12-07 01:11:35.995769-06
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('django_migrations_id_seq', 22, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: test
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: test
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: message_message; Type: TABLE DATA; Schema: public; Owner: test
--

COPY message_message (id, subject, message, read, date, is_reservation, receiver_id, sender_id) FROM stdin;
2	Reservation Request	I want one.	f	2015-12-07	t	1	1
3	Your payment information is out of date	\n              mprouve attempted to approve your  reservation request for a parking spot at 222 Langdon St., but was unable to\n              becuase your payment information was rejected. Please update your payment information, which can be done so\n              through your user profile settings\n              	f	2015-12-07	f	1	1
4	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 222 Langdon St. Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
5	Reservation Request	I want 2 spots.	f	2015-12-07	t	1	1
6	Reservation Request	I want 1 spot.	f	2015-12-07	t	1	1
7	Reservation Request	I want 5 spots please	f	2015-12-07	t	1	1
8	Reservation Request	I want 3 Please	f	2015-12-07	t	1	1
9	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 633 N Henry Street Madison, WI for the date: 12/06/2015.	f	2015-12-07	f	1	1
10	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 621 N. Frances St. Madison, WI for the date: 12/06/2015.	f	2015-12-07	f	1	1
11	Your request for a parking spot could not be fulfilled.	We're sorry.  We were unable to book a parking spot at 437 N. Frances St. Madison, WI for the date: 2015-12-30 00:00:00+00:00.	f	2015-12-07	f	1	1
12	Reservation Request	I would Like 3 please.	f	2015-12-07	t	1	1
13	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 633 N Henry Street Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
14	Reservation Request	I would like 2 spots please.	f	2015-12-07	t	1	1
15	Reservation Request	I would like 2 spots please.	f	2015-12-07	t	1	1
16	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 621 N. Frances St. Madison, WI for the date: 12/06/2015.	f	2015-12-07	f	1	1
17	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 437 N. Frances St. Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
18	RE: Congratulations!  Your parking spot(s) request has been approved.	\r\n\r\n\r\n-------------------------------------------------\r\nYou've successfully booked a parking spot at 437 N. Frances St. Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
19	RE: RE: Congratulations!  Your parking spot(s) request has been approved.	\r\n\r\n\r\n-------------------------------------------------\r\n\r\n\r\n\r\n-------------------------------------------------\r\nYou've successfully booked a parking spot at 437 N. Frances St. Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
20	RE: RE: RE: Congratulations!  Your parking spot(s) request has been approved.	\r\n\r\n\r\n-------------------------------------------------\r\n\r\n\r\n\r\n-------------------------------------------------\r\n\r\n\r\n\r\n-------------------------------------------------\r\nYou've successfully booked a parking spot at 437 N. Frances St. Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
21	RE: Congratulations!  Your parking spot(s) request has been approved.	\r\n\r\n\r\n-------------------------------------------------\r\nYou've successfully booked a parking spot at 437 N. Frances St. Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
22	RE: Your payment information is out of date	hey\r\n\r\n\r\n-------------------------------------------------\r\n\r\n              mprouve attempted to approve your  reservation request for a parking spot at 222 Langdon St., but was unable to\r\n              becuase your payment information was rejected. Please update your payment information, which can be done so\r\n              through your user profile settings\r\n              	f	2015-12-07	f	1	1
23	Reservation Request	Hello.  It's me.\r\n	f	2015-12-07	t	1	1
24	Reservation Request	message to owner	f	2015-12-07	t	1	1
25	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 633 N Henry Street Madison, WI for the date: 12/06/2015.	f	2015-12-07	f	1	1
27	Reservation Request	Hello.	f	2015-12-07	t	1	1
28	Congratulations!  Your parking spot(s) request has been approved.	You've successfully booked a parking spot at 633 N Henry Street Madison, WI for the date: 12/30/2015.	f	2015-12-07	f	1	1
\.


--
-- Name: message_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('message_message_id_seq', 28, true);


--
-- Data for Name: message_resmessage; Type: TABLE DATA; Schema: public; Owner: test
--

COPY message_resmessage (id, res_date, is_approved, has_responded, transaction_id, num_spots, message_id, parkingspot_id, reviewed_id) FROM stdin;
2	2015-12-29 18:00:00-06	t	t	ch_17FFoeLAT2RWkw5PaipB55cE	1	2	5	\N
6	2015-12-05 18:00:00-06	t	t	ch_17FFx4LAT2RWkw5P5b6DZTsL	3	8	7	1
5	2015-12-05 18:00:00-06	t	t	ch_17FFwzLAT2RWkw5PMjkcAPRZ	5	7	6	2
3	2015-12-29 18:00:00-06	f	t	\N	2	5	4	\N
7	2015-12-29 18:00:00-06	t	t	ch_17FH98LAT2RWkw5PNz1Ibk7Y	3	12	6	\N
8	2015-12-05 18:00:00-06	t	t	ch_17FHw2LAT2RWkw5PKDtopgey	2	14	7	\N
4	2015-12-29 18:00:00-06	t	t	ch_17FHwULAT2RWkw5PPzhJAuZL	1	6	4	\N
10	2015-12-29 18:00:00-06	f	f	\N	4	23	3	\N
11	2015-12-29 18:00:00-06	f	f	\N	1	24	7	\N
9	2015-12-05 18:00:00-06	t	t	ch_17FW0ULAT2RWkw5PyuGjDLS4	2	15	6	\N
13	2015-12-29 18:00:00-06	t	t	ch_17FWAcLAT2RWkw5PrpOFPKP0	2	27	6	\N
\.


--
-- Name: message_resmessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('message_resmessage_id_seq', 13, true);


--
-- Data for Name: parkingspot_parkingspot; Type: TABLE DATA; Schema: public; Owner: test
--

COPY parkingspot_parkingspot (id, street_address, city, state, zipcode, location, description, amenities, cost, photos, default_num_spots, parking_spot_avail, owner_id) FROM stdin;
7	621 N. Frances St.	Madison	WI	53706	0101000020E610000076C4211B485956C09CFA40F2CE894540	This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.	{"electricity":false,"grill":false,"bathroom":false,"yard":false,"table":false}	1	photos/7/woodBackground_yTfY7Mn.jpg	10	{"dates":{"12/30/2015":{"max":10,"res":[]},"12/06/2015":{"max":10,"res":[1,1,1,1,1]}}}	1
5	222 Langdon St.	Madison	WI	53706	0101000020E6100000588B4F01305956C05DA79196CA894540	NoneThis is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.	{"electricity":true,"grill":true,"bathroom":true,"yard":true,"table":true}	3	photos/5/homeBackground1.jpg	10	{"dates":{"12/30/2015":{"max":10,"res":[1]}}}	1
3	221 Langdon St.	Madison	WI	53706	0101000020E61000009352D0ED255956C064AF777FBC894540	This is a description. This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.	{"electricity":false,"grill":false,"bathroom":true,"yard":true,"table":false}	5	photos/3/field.jpg	10	{"dates":{"12/30/2015":{"max":10,"res":[]}}}	1
4	437 N. Frances St.	Madison	WI	53706	0101000020E6100000C37BB372545956C00798F90E7E894540	This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.This is a description.	{"electricity":false,"grill":true,"bathroom":true,"yard":true,"table":false}	4	photos/4/lightsBackground.jpg	10	{"dates":{"12/31/2015":{"max":10,"res":[]},"12/30/2015":{"max":10,"res":[1]}}}	1
2	614 Langdon St.	Madison	WI	53706	0101000020E610000019E0826C595956C01155F833BC894540	This is a description.This is a description.This is a description.	{"electricity":false,"grill":false,"bathroom":false,"yard":true,"table":true}	6	photos/2/lightsBackground.jpg	10	{"dates":{"12/30/2015":{"max":10,"res":[]}}}	1
1	420 Langdon St.	Madison	WI	53706	0101000020E6100000B61D09EA4A5956C0B6B28EF4B3894540	This is a description. This is a description. This is a description. This is a description. This is a description. This is a description. This is a description. This is a description. This is a description. This is a description.	{"electricity":false,"grill":false,"bathroom":true,"yard":false,"table":true}	7	photos/1/homeBackground1.jpg	10	{"dates":{"12/30/2015":{"max":10,"res":[]}}}	1
8	613 N. Frances St.	Madison	AL	53706	0101000020E61000005E9CF86A475956C029B4ACFBC7894540	This is a Description. This is a Description. This is a Description. This is a Description. This is a Description. This is a Description. 	{"electricity":false,"grill":true,"bathroom":false,"yard":true,"table":false}	8	photos/8/woodBackground.jpg	10	{"dates":{"":{"max":10,"res":[]}}}	1
6	633 N Henry Street	Madison	WI	53706	0101000020E6100000BBDC161B295956C08B4061F5EC894540	ryans spot	{"electricity":true,"grill":false,"bathroom":false,"yard":false,"table":false}	2	photos/6/homeBackground1.jpg	10	{"dates":{"12/31/2015":{"max":10,"res":[]},"12/29/2015":{"max":10,"res":[]},"12/30/2015":{"max":10,"res":[1,1,1,1,1]},"12/06/2015":{"max":10,"res":[1,1,1,1,1,1,1]}}}	1
\.


--
-- Name: parkingspot_parkingspot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('parkingspot_parkingspot_id_seq', 8, true);


--
-- Data for Name: review_review; Type: TABLE DATA; Schema: public; Owner: test
--

COPY review_review (id, headline, review_text, rating, parkingspot_id, reviewer_id) FROM stdin;
1	Great Spot!	This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. 	5	7	1
2	Horrible Spot!	This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. This is a long Review. 	1	6	1
\.


--
-- Name: review_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('review_review_id_seq', 2, true);


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: test
--

COPY socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
1	facebook	10154320941381102	2015-12-07 14:56:20.129186-06	2015-12-07 14:56:20.129206-06	{"first_name": "Marco", "last_name": "Prouve", "verified": true, "name": "Marco Prouve", "locale": "en_US", "gender": "male", "email": "mprouve@optonline.net", "link": "https://www.facebook.com/app_scoped_user_id/10154320941381102/", "timezone": -6, "updated_time": "2015-06-15T04:52:43+0000", "id": "10154320941381102"}	2
\.


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('socialaccount_socialaccount_id_seq', 1, true);


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: test
--

COPY socialaccount_socialapp (id, provider, name, client_id, secret, key) FROM stdin;
1	facebook	Gameday App	445644008954900	33a202dc65e409bca3abe8b08685eabe	
\.


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('socialaccount_socialapp_id_seq', 1, true);


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: test
--

COPY socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
1	1	1
\.


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('socialaccount_socialapp_sites_id_seq', 1, true);


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: test
--

COPY socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
1	CAAGVT5TZAnBQBAIpujniBdj6LR5bbBNYf2cm56hZAcgVJua5Ghanh7R2QCFvCn897CU5a7ZAHgujE5t9PVgIY7DObsHNWWsnwRjOhpRd5ZAl7sVqE4CPHF8MHuL5ZBq3pLSVfwaAQpqZAWCkiQYRpnVqqfT08R3gh71giBVol01QGhZA4250b4Sxm6Fh5wzJ61E2o1bsexlf1KUZBWozGOtJ92G7HZBd6UR2MBLN4m7F7cgTAnoFP9y377u7ZA0Al7UagdwZBJFF0vUmbFfA3jiJjR3Qw48gI8DoD1OPvbySpwOWwZDZD		\N	1	1
\.


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('socialaccount_socialtoken_id_seq', 1, true);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: userprof_adminuser; Type: TABLE DATA; Schema: public; Owner: test
--

COPY userprof_adminuser (registered, extended_user_id) FROM stdin;
t	1
\.


--
-- Data for Name: userprof_extendeduser; Type: TABLE DATA; Schema: public; Owner: test
--

COPY userprof_extendeduser (main_user_id, stripe_id) FROM stdin;
1	cus_7UEHxIu7i3VJWc
2	\N
\.


SET search_path = topology, pg_catalog;

--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Name: account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_45f3b1d93ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: message_message_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY message_message
    ADD CONSTRAINT message_message_pkey PRIMARY KEY (id);


--
-- Name: message_resmessage_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY message_resmessage
    ADD CONSTRAINT message_resmessage_pkey PRIMARY KEY (id);


--
-- Name: parkingspot_parkingspot_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY parkingspot_parkingspot
    ADD CONSTRAINT parkingspot_parkingspot_pkey PRIMARY KEY (id);


--
-- Name: review_review_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY review_review
    ADD CONSTRAINT review_review_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_provider_36eec1734f431f56_uniq; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_36eec1734f431f56_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_socialapp_id_site_id_key UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialtoken_app_id_697928748c2e1968_uniq; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_697928748c2e1968_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: userprof_adminuser_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY userprof_adminuser
    ADD CONSTRAINT userprof_adminuser_pkey PRIMARY KEY (extended_user_id);


--
-- Name: userprof_extendeduser_pkey; Type: CONSTRAINT; Schema: public; Owner: test; Tablespace: 
--

ALTER TABLE ONLY userprof_extendeduser
    ADD CONSTRAINT userprof_extendeduser_pkey PRIMARY KEY (main_user_id);


--
-- Name: account_emailaddress_e8701ad4; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX account_emailaddress_e8701ad4 ON account_emailaddress USING btree (user_id);


--
-- Name: account_emailaddress_email_206527469d8e1918_like; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX account_emailaddress_email_206527469d8e1918_like ON account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailconfirmation_6f1edeac; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX account_emailconfirmation_6f1edeac ON account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_7033a271201d424f_like; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX account_emailconfirmation_key_7033a271201d424f_like ON account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_name_253ae2a6331666e8_like; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_group_name_253ae2a6331666e8_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_51b3b110094b8aae_like; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX auth_user_username_51b3b110094b8aae_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_461cfeaa630ca218_like; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX django_session_session_key_461cfeaa630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: message_message_924b1846; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX message_message_924b1846 ON message_message USING btree (sender_id);


--
-- Name: message_message_d41c2251; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX message_message_d41c2251 ON message_message USING btree (receiver_id);


--
-- Name: message_resmessage_4ccaa172; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX message_resmessage_4ccaa172 ON message_resmessage USING btree (message_id);


--
-- Name: message_resmessage_586cd4d1; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX message_resmessage_586cd4d1 ON message_resmessage USING btree (parkingspot_id);


--
-- Name: message_resmessage_7d6121ab; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX message_resmessage_7d6121ab ON message_resmessage USING btree (reviewed_id);


--
-- Name: parkingspot_parkingspot_5e7b1936; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX parkingspot_parkingspot_5e7b1936 ON parkingspot_parkingspot USING btree (owner_id);


--
-- Name: parkingspot_parkingspot_location_id; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX parkingspot_parkingspot_location_id ON parkingspot_parkingspot USING gist (location);


--
-- Name: review_review_071d8141; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX review_review_071d8141 ON review_review USING btree (reviewer_id);


--
-- Name: review_review_586cd4d1; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX review_review_586cd4d1 ON review_review USING btree (parkingspot_id);


--
-- Name: socialaccount_socialaccount_e8701ad4; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX socialaccount_socialaccount_e8701ad4 ON socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_9365d6e7; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_9365d6e7 ON socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_fe95b0a0; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_fe95b0a0 ON socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_8a089c2a; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_8a089c2a ON socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_f382adfe; Type: INDEX; Schema: public; Owner: test; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_f382adfe ON socialaccount_socialtoken USING btree (app_id);


--
-- Name: D71b121645599e12f01ed548155bc958; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY userprof_adminuser
    ADD CONSTRAINT "D71b121645599e12f01ed548155bc958" FOREIGN KEY (extended_user_id) REFERENCES userprof_extendeduser(main_user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ac_email_address_id_5bcf9f503c32d4d8_fk_account_emailaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT ac_email_address_id_5bcf9f503c32d4d8_fk_account_emailaddress_id FOREIGN KEY (email_address_id) REFERENCES account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailaddress_user_id_5c85949e40d9a61d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_5c85949e40d9a61d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_508cf46651277a81_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_697914295151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: f0bf84a2291855f3babdebed0a1d00e0; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY parkingspot_parkingspot
    ADD CONSTRAINT f0bf84a2291855f3babdebed0a1d00e0 FOREIGN KEY (owner_id) REFERENCES userprof_adminuser(extended_user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: m_parkingspot_id_1f1b56e48cd15670_fk_parkingspot_parkingspot_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY message_resmessage
    ADD CONSTRAINT m_parkingspot_id_1f1b56e48cd15670_fk_parkingspot_parkingspot_id FOREIGN KEY (parkingspot_id) REFERENCES parkingspot_parkingspot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: message_message_receiver_id_3f11b3151635f69f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY message_message
    ADD CONSTRAINT message_message_receiver_id_3f11b3151635f69f_fk_auth_user_id FOREIGN KEY (receiver_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: message_message_sender_id_41072dedef924eb3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY message_message
    ADD CONSTRAINT message_message_sender_id_41072dedef924eb3_fk_auth_user_id FOREIGN KEY (sender_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: message_resme_message_id_4bb732cbf323b283_fk_message_message_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY message_resmessage
    ADD CONSTRAINT message_resme_message_id_4bb732cbf323b283_fk_message_message_id FOREIGN KEY (message_id) REFERENCES message_message(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: message_resmes_reviewed_id_56dde3f15296b5c4_fk_review_review_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY message_resmessage
    ADD CONSTRAINT message_resmes_reviewed_id_56dde3f15296b5c4_fk_review_review_id FOREIGN KEY (reviewed_id) REFERENCES review_review(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: r_parkingspot_id_77c8ae9174163455_fk_parkingspot_parkingspot_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY review_review
    ADD CONSTRAINT r_parkingspot_id_77c8ae9174163455_fk_parkingspot_parkingspot_id FOREIGN KEY (parkingspot_id) REFERENCES parkingspot_parkingspot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: review_review_reviewer_id_3ae9575bfeb01d87_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY review_review
    ADD CONSTRAINT review_review_reviewer_id_3ae9575bfeb01d87_fk_auth_user_id FOREIGN KEY (reviewer_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: s_account_id_3fc809e243dd8c0a_fk_socialaccount_socialaccount_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT s_account_id_3fc809e243dd8c0a_fk_socialaccount_socialaccount_id FOREIGN KEY (account_id) REFERENCES socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: soc_socialapp_id_7b02380b6127b1b8_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT soc_socialapp_id_7b02380b6127b1b8_fk_socialaccount_socialapp_id FOREIGN KEY (socialapp_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialacco_app_id_2125549785bd662_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialacco_app_id_2125549785bd662_fk_socialaccount_socialapp_id FOREIGN KEY (app_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_sociala_site_id_a859406a22be3fe_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_sociala_site_id_a859406a22be3fe_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialac_user_id_3fd78aac97693583_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialac_user_id_3fd78aac97693583_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprof_extended_main_user_id_60503167f835e300_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY userprof_extendeduser
    ADD CONSTRAINT userprof_extended_main_user_id_60503167f835e300_fk_auth_user_id FOREIGN KEY (main_user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

