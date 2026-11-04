.class public final Lcom/fasterxml/aalto/util/UriCanonicalizer;
.super Ljava/lang/Object;
.source "UriCanonicalizer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;,
        Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;
    }
.end annotation


# instance fields
.field private mURIs:Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer;->mURIs:Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;

    .line 16
    return-void
.end method

.method private init()V
    .locals 1

    .line 20
    new-instance v0, Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;

    invoke-direct {v0}, Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer;->mURIs:Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;

    .line 21
    return-void
.end method


# virtual methods
.method public declared-synchronized canonicalizeURI([CI)Ljava/lang/String;
    .locals 3
    .param p1, "ch"    # [C
    .param p2, "len"    # I

    monitor-enter p0

    .line 25
    :try_start_0
    new-instance v0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;

    invoke-direct {v0, p1, p2}, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;-><init>([CI)V

    .line 26
    .local v0, "key":Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;
    iget-object v1, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer;->mURIs:Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;

    if-nez v1, :cond_0

    .line 27
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/UriCanonicalizer;->init()V

    goto :goto_0

    .line 29
    .end local p0    # "this":Lcom/fasterxml/aalto/util/UriCanonicalizer;
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer;->mURIs:Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 30
    .local v1, "result":Ljava/lang/String;
    if-eqz v1, :cond_1

    .line 31
    monitor-exit p0

    return-object v1

    .line 37
    .end local v1    # "result":Ljava/lang/String;
    :cond_1
    :goto_0
    :try_start_1
    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->safeClone()Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;

    move-result-object v1

    move-object v0, v1

    .line 39
    new-instance v1, Ljava/lang/String;

    const/4 v2, 0x0

    invoke-direct {v1, p1, v2, p2}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {v1}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v1

    .line 40
    .local v1, "uri":Ljava/lang/String;
    iget-object v2, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer;->mURIs:Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;

    invoke-virtual {v2, v0, v1}, Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 41
    monitor-exit p0

    return-object v1

    .line 24
    .end local v0    # "key":Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;
    .end local v1    # "uri":Ljava/lang/String;
    .end local p1    # "ch":[C
    .end local p2    # "len":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
