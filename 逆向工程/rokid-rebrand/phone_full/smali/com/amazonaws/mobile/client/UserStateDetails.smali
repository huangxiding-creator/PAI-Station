.class public Lcom/amazonaws/mobile/client/UserStateDetails;
.super Ljava/lang/Object;
.source "UserStateDetails.java"


# instance fields
.field private final details:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private exception:Ljava/lang/Exception;

.field private final userState:Lcom/amazonaws/mobile/client/UserState;


# direct methods
.method public constructor <init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V
    .locals 0
    .param p1, "userState"    # Lcom/amazonaws/mobile/client/UserState;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/UserState;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 29
    .local p2, "details":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput-object p1, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->userState:Lcom/amazonaws/mobile/client/UserState;

    .line 31
    iput-object p2, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->details:Ljava/util/Map;

    .line 32
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "obj"    # Ljava/lang/Object;

    .line 52
    instance-of v0, p1, Lcom/amazonaws/mobile/client/UserStateDetails;

    if-eqz v0, :cond_3

    .line 53
    move-object v0, p1

    check-cast v0, Lcom/amazonaws/mobile/client/UserStateDetails;

    .line 55
    .local v0, "other":Lcom/amazonaws/mobile/client/UserStateDetails;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->userState:Lcom/amazonaws/mobile/client/UserState;

    iget-object v2, v0, Lcom/amazonaws/mobile/client/UserStateDetails;->userState:Lcom/amazonaws/mobile/client/UserState;

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/client/UserState;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    .line 56
    return v2

    .line 59
    :cond_0
    iget-object v1, v0, Lcom/amazonaws/mobile/client/UserStateDetails;->details:Ljava/util/Map;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->details:Ljava/util/Map;

    if-ne v1, v3, :cond_1

    .line 60
    const/4 v1, 0x1

    return v1

    .line 61
    :cond_1
    iget-object v1, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->details:Ljava/util/Map;

    if-nez v1, :cond_2

    .line 62
    return v2

    .line 64
    :cond_2
    iget-object v1, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->details:Ljava/util/Map;

    iget-object v2, v0, Lcom/amazonaws/mobile/client/UserStateDetails;->details:Ljava/util/Map;

    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    return v1

    .line 67
    .end local v0    # "other":Lcom/amazonaws/mobile/client/UserStateDetails;
    :cond_3
    invoke-super {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public getDetails()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 39
    iget-object v0, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->details:Ljava/util/Map;

    return-object v0
.end method

.method protected getException()Ljava/lang/Exception;
    .locals 1

    .line 47
    iget-object v0, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->exception:Ljava/lang/Exception;

    return-object v0
.end method

.method public getUserState()Lcom/amazonaws/mobile/client/UserState;
    .locals 1

    .line 35
    iget-object v0, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->userState:Lcom/amazonaws/mobile/client/UserState;

    return-object v0
.end method

.method protected setException(Ljava/lang/Exception;)V
    .locals 0
    .param p1, "exception"    # Ljava/lang/Exception;

    .line 43
    iput-object p1, p0, Lcom/amazonaws/mobile/client/UserStateDetails;->exception:Ljava/lang/Exception;

    .line 44
    return-void
.end method
