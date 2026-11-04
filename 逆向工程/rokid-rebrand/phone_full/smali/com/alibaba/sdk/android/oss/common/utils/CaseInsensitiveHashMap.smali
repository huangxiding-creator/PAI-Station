.class public Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap;
.super Ljava/util/HashMap;
.source "CaseInsensitiveHashMap.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<k:",
        "Ljava/lang/Object;",
        "v:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/util/HashMap<",
        "Tk;Tv;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    .local p0, "this":Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap;, "Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap<Tk;Tv;>;"
    invoke-direct {p0}, Ljava/util/HashMap;-><init>()V

    return-void
.end method


# virtual methods
.method public get(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p1, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")Tv;"
        }
    .end annotation

    .line 14
    .local p0, "this":Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap;, "Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap<Tk;Tv;>;"
    if-eqz p1, :cond_1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 15
    move-object v0, p1

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 16
    .local v0, "lowCaseKey":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 17
    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/oss/common/utils/CaseInsensitiveHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    return-object v1

    .line 19
    :cond_0
    const/4 v1, 0x0

    return-object v1

    .line 22
    .end local v0    # "lowCaseKey":Ljava/lang/String;
    :cond_1
    invoke-super {p0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
