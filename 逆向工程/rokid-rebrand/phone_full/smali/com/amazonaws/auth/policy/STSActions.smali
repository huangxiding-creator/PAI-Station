.class public final enum Lcom/amazonaws/auth/policy/STSActions;
.super Ljava/lang/Enum;
.source "STSActions.java"

# interfaces
.implements Lcom/amazonaws/auth/policy/Action;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/auth/policy/STSActions;",
        ">;",
        "Lcom/amazonaws/auth/policy/Action;"
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/auth/policy/STSActions;

.field public static final enum AssumeRole:Lcom/amazonaws/auth/policy/STSActions;

.field public static final enum AssumeRoleWithWebIdentity:Lcom/amazonaws/auth/policy/STSActions;


# instance fields
.field private final action:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 36
    new-instance v0, Lcom/amazonaws/auth/policy/STSActions;

    const/4 v1, 0x0

    const-string/jumbo v2, "sts:AssumeRole"

    const-string v3, "AssumeRole"

    invoke-direct {v0, v3, v1, v2}, Lcom/amazonaws/auth/policy/STSActions;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/auth/policy/STSActions;->AssumeRole:Lcom/amazonaws/auth/policy/STSActions;

    .line 45
    new-instance v0, Lcom/amazonaws/auth/policy/STSActions;

    const/4 v1, 0x1

    const-string/jumbo v2, "sts:AssumeRoleWithWebIdentity"

    const-string v3, "AssumeRoleWithWebIdentity"

    invoke-direct {v0, v3, v1, v2}, Lcom/amazonaws/auth/policy/STSActions;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/auth/policy/STSActions;->AssumeRoleWithWebIdentity:Lcom/amazonaws/auth/policy/STSActions;

    .line 28
    sget-object v0, Lcom/amazonaws/auth/policy/STSActions;->AssumeRole:Lcom/amazonaws/auth/policy/STSActions;

    sget-object v1, Lcom/amazonaws/auth/policy/STSActions;->AssumeRoleWithWebIdentity:Lcom/amazonaws/auth/policy/STSActions;

    filled-new-array {v0, v1}, [Lcom/amazonaws/auth/policy/STSActions;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/auth/policy/STSActions;->$VALUES:[Lcom/amazonaws/auth/policy/STSActions;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "action"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 49
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 50
    iput-object p3, p0, Lcom/amazonaws/auth/policy/STSActions;->action:Ljava/lang/String;

    .line 51
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/auth/policy/STSActions;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 28
    const-class v0, Lcom/amazonaws/auth/policy/STSActions;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/auth/policy/STSActions;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/auth/policy/STSActions;
    .locals 1

    .line 28
    sget-object v0, Lcom/amazonaws/auth/policy/STSActions;->$VALUES:[Lcom/amazonaws/auth/policy/STSActions;

    invoke-virtual {v0}, [Lcom/amazonaws/auth/policy/STSActions;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/auth/policy/STSActions;

    return-object v0
.end method


# virtual methods
.method public getActionName()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/amazonaws/auth/policy/STSActions;->action:Ljava/lang/String;

    return-object v0
.end method
