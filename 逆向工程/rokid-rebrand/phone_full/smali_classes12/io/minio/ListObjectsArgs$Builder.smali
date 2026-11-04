.class public final Lio/minio/ListObjectsArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "ListObjectsArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ListObjectsArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/ListObjectsArgs$Builder;",
        "Lio/minio/ListObjectsArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 101
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$continuationToken$7(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "continuationToken"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 162
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$602(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$delimiter$0(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V
    .locals 1
    .param p0, "delimiter"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 121
    if-nez p0, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    move-object v0, p0

    :goto_0
    invoke-static {p1, v0}, Lio/minio/ListObjectsArgs;->access$1102(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$fetchOwner$8(ZLio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "fetchOwner"    # Z
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 167
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$502(Lio/minio/ListObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$includeUserMetadata$10(ZLio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "includeUserMetadata"    # Z
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 178
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$402(Lio/minio/ListObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$includeVersions$13(ZLio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "includeVersions"    # Z
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 193
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$102(Lio/minio/ListObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$keyMarker$2(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "keyMarker"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 132
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$902(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$marker$3(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "marker"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 137
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$902(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$maxKeys$5(ILio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "maxKeys"    # I
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 151
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$802(Lio/minio/ListObjectsArgs;I)I

    return-void
.end method

.method static synthetic lambda$prefix$6(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V
    .locals 1
    .param p0, "prefix"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 156
    if-nez p0, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    move-object v0, p0

    :goto_0
    invoke-static {p1, v0}, Lio/minio/ListObjectsArgs;->access$702(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$recursive$11(ZLio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "recursive"    # Z
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 183
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$302(Lio/minio/ListObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$startAfter$4(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "startAfter"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 142
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$902(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$useApiVersion1$12(ZLio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "useApiVersion1"    # Z
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 188
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$202(Lio/minio/ListObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$useUrlEncodingType$1(ZLio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "flag"    # Z
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 126
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$1002(Lio/minio/ListObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$versionIdMarker$9(Ljava/lang/String;Lio/minio/ListObjectsArgs;)V
    .locals 0
    .param p0, "versionIdMarker"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 173
    invoke-static {p1, p0}, Lio/minio/ListObjectsArgs;->access$002(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public continuationToken(Ljava/lang/String;)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "continuationToken"    # Ljava/lang/String;

    .line 161
    const-string v0, "continuation token"

    invoke-virtual {p0, p1, v0}, Lio/minio/ListObjectsArgs$Builder;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 162
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda11;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda11;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 163
    return-object p0
.end method

.method public delimiter(Ljava/lang/String;)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "delimiter"    # Ljava/lang/String;

    .line 121
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 122
    return-object p0
.end method

.method public fetchOwner(Z)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "fetchOwner"    # Z

    .line 167
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda12;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda12;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 168
    return-object p0
.end method

.method public includeUserMetadata(Z)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "includeUserMetadata"    # Z

    .line 178
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda9;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda9;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 179
    return-object p0
.end method

.method public includeVersions(Z)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "includeVersions"    # Z

    .line 193
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda0;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 194
    return-object p0
.end method

.method public keyMarker(Ljava/lang/String;)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "keyMarker"    # Ljava/lang/String;

    .line 131
    const-string v0, "key marker"

    invoke-virtual {p0, p1, v0}, Lio/minio/ListObjectsArgs$Builder;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 132
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda5;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda5;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 133
    return-object p0
.end method

.method public marker(Ljava/lang/String;)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "marker"    # Ljava/lang/String;

    .line 137
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda10;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda10;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 138
    return-object p0
.end method

.method public maxKeys(I)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "maxKeys"    # I

    .line 147
    const/4 v0, 0x1

    if-lt p1, v0, :cond_0

    const/16 v0, 0x3e8

    if-gt p1, v0, :cond_0

    .line 151
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda4;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda4;-><init>(I)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 152
    return-object p0

    .line 148
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "max keys must be between 1 and 1000"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public prefix(Ljava/lang/String;)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;

    .line 156
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda2;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 157
    return-object p0
.end method

.method public recursive(Z)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "recursive"    # Z

    .line 183
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda8;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda8;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 184
    return-object p0
.end method

.method public startAfter(Ljava/lang/String;)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "startAfter"    # Ljava/lang/String;

    .line 142
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda13;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda13;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 143
    return-object p0
.end method

.method public useApiVersion1(Z)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "useApiVersion1"    # Z

    .line 188
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda3;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda3;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 189
    return-object p0
.end method

.method public useUrlEncodingType(Z)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "flag"    # Z

    .line 126
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda6;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda6;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 127
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 101
    check-cast p1, Lio/minio/ListObjectsArgs;

    invoke-virtual {p0, p1}, Lio/minio/ListObjectsArgs$Builder;->validate(Lio/minio/ListObjectsArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 101
    check-cast p1, Lio/minio/ListObjectsArgs;

    invoke-virtual {p0, p1}, Lio/minio/ListObjectsArgs$Builder;->validate(Lio/minio/ListObjectsArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/ListObjectsArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/ListObjectsArgs;

    .line 104
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 106
    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->useApiVersion1()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->includeVersions()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 107
    :cond_0
    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->continuationToken()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_4

    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->fetchOwner()Z

    move-result v0

    if-nez v0, :cond_4

    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->includeUserMetadata()Z

    move-result v0

    if-nez v0, :cond_4

    .line 114
    :cond_1
    invoke-static {p1}, Lio/minio/ListObjectsArgs;->access$000(Lio/minio/ListObjectsArgs;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->useApiVersion1()Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    .line 115
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string/jumbo v1, "version ID marker is not supported for list objects version 1"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 118
    :cond_3
    :goto_0
    return-void

    .line 108
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "continuation token/fetch owner/include metadata are supported only for list objects version 2"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public versionIdMarker(Ljava/lang/String;)Lio/minio/ListObjectsArgs$Builder;
    .locals 2
    .param p1, "versionIdMarker"    # Ljava/lang/String;

    .line 172
    const-string/jumbo v0, "version ID marker"

    invoke-virtual {p0, p1, v0}, Lio/minio/ListObjectsArgs$Builder;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 173
    iget-object v0, p0, Lio/minio/ListObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda7;

    invoke-direct {v1, p1}, Lio/minio/ListObjectsArgs$Builder$$ExternalSyntheticLambda7;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 174
    return-object p0
.end method
