.class public final enum Lio/minio/messages/RetentionMode;
.super Ljava/lang/Enum;
.source "RetentionMode.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/RetentionMode;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/RetentionMode;

.field public static final enum COMPLIANCE:Lio/minio/messages/RetentionMode;

.field public static final enum GOVERNANCE:Lio/minio/messages/RetentionMode;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/RetentionMode;
    .locals 2

    .line 20
    sget-object v0, Lio/minio/messages/RetentionMode;->GOVERNANCE:Lio/minio/messages/RetentionMode;

    sget-object v1, Lio/minio/messages/RetentionMode;->COMPLIANCE:Lio/minio/messages/RetentionMode;

    filled-new-array {v0, v1}, [Lio/minio/messages/RetentionMode;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 21
    new-instance v0, Lio/minio/messages/RetentionMode;

    const-string v1, "GOVERNANCE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/messages/RetentionMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/RetentionMode;->GOVERNANCE:Lio/minio/messages/RetentionMode;

    .line 22
    new-instance v0, Lio/minio/messages/RetentionMode;

    const-string v1, "COMPLIANCE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/minio/messages/RetentionMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/RetentionMode;->COMPLIANCE:Lio/minio/messages/RetentionMode;

    .line 20
    invoke-static {}, Lio/minio/messages/RetentionMode;->$values()[Lio/minio/messages/RetentionMode;

    move-result-object v0

    sput-object v0, Lio/minio/messages/RetentionMode;->$VALUES:[Lio/minio/messages/RetentionMode;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/RetentionMode;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 20
    const-class v0, Lio/minio/messages/RetentionMode;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/RetentionMode;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/RetentionMode;
    .locals 1

    .line 20
    sget-object v0, Lio/minio/messages/RetentionMode;->$VALUES:[Lio/minio/messages/RetentionMode;

    invoke-virtual {v0}, [Lio/minio/messages/RetentionMode;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/RetentionMode;

    return-object v0
.end method
