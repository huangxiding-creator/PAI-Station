.class public final Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;
.super Ljava/lang/Object;
.source "SPUtil.kt"

# interfaces
.implements Lkotlin/properties/ReadWriteProperty;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->booleanPreference(Ljava/lang/String;Z)Lkotlin/properties/ReadWriteProperty;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lkotlin/properties/ReadWriteProperty<",
        "Ljava/lang/Object;",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000%\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u0010\u0012\u0006\u0012\u0004\u0018\u00010\u0002\u0012\u0004\u0012\u00020\u00030\u0001J$\u0010\u0004\u001a\u00020\u00032\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00022\n\u0010\u0006\u001a\u0006\u0012\u0002\u0008\u00030\u0007H\u0096\u0002\u00a2\u0006\u0002\u0010\u0008J\'\u0010\t\u001a\u00020\n2\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00022\n\u0010\u0006\u001a\u0006\u0012\u0002\u0008\u00030\u00072\u0006\u0010\u000b\u001a\u00020\u0003H\u0096\u0002\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1",
        "Lkotlin/properties/ReadWriteProperty;",
        "",
        "",
        "getValue",
        "thisRef",
        "property",
        "Lkotlin/reflect/KProperty;",
        "(Ljava/lang/Object;Lkotlin/reflect/KProperty;)Ljava/lang/Boolean;",
        "setValue",
        "",
        "value",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $defaultValue:Z

.field final synthetic $key:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/utils/SPUtil;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;Z)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/utils/SPUtil;
    .param p2, "$key"    # Ljava/lang/String;
    .param p3, "$defaultValue"    # Z

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->this$0:Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->$key:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->$defaultValue:Z

    .line 180
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getValue(Ljava/lang/Object;Lkotlin/reflect/KProperty;)Ljava/lang/Boolean;
    .locals 3
    .param p1, "thisRef"    # Ljava/lang/Object;
    .param p2, "property"    # Lkotlin/reflect/KProperty;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/reflect/KProperty<",
            "*>;)",
            "Ljava/lang/Boolean;"
        }
    .end annotation

    const-string v0, "property"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 182
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->this$0:Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->$key:Ljava/lang/String;

    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->$defaultValue:Z

    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getValue(Ljava/lang/Object;Lkotlin/reflect/KProperty;)Ljava/lang/Object;
    .locals 1
    .param p1, "thisRef"    # Ljava/lang/Object;
    .param p2, "property"    # Lkotlin/reflect/KProperty;

    .line 180
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->getValue(Ljava/lang/Object;Lkotlin/reflect/KProperty;)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic setValue(Ljava/lang/Object;Lkotlin/reflect/KProperty;Ljava/lang/Object;)V
    .locals 1
    .param p1, "thisRef"    # Ljava/lang/Object;
    .param p2, "property"    # Lkotlin/reflect/KProperty;
    .param p3, "value"    # Ljava/lang/Object;

    .line 180
    move-object v0, p3

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {p0, p1, p2, v0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->setValue(Ljava/lang/Object;Lkotlin/reflect/KProperty;Z)V

    return-void
.end method

.method public setValue(Ljava/lang/Object;Lkotlin/reflect/KProperty;Z)V
    .locals 2
    .param p1, "thisRef"    # Ljava/lang/Object;
    .param p2, "property"    # Lkotlin/reflect/KProperty;
    .param p3, "value"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/reflect/KProperty<",
            "*>;Z)V"
        }
    .end annotation

    const-string v0, "property"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 186
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->this$0:Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;->$key:Ljava/lang/String;

    invoke-virtual {v0, v1, p3}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->putBoolean(Ljava/lang/String;Z)V

    .line 187
    return-void
.end method
